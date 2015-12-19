_ = require('lodash')
vm = require('vm')
assert = require('assert')
accumulator = require('./vendor/accumulator')

GLOBALS = { Buffer, __dirname, __filename, clearInterval, clearTimeout, console,
            exports, global, module, process, require, setInterval, setTimeout }

module.exports = (codeBlock, adapter, cb) ->
  collector = accumulator(cb)
  codeAndAssertions = preprocessCodeBlock(collector, codeBlock, adapter)
  sandbox = vm.createContext _.extend {}, GLOBALS,
    __docunit:
      assertions: codeAndAssertions.assertions
      assert: assert
  vm.runInContext(codeAndAssertions.code, sandbox)
  if codeAndAssertions.assertions.length == 0
    collector()(null, accumulator.SKIP_RESULT) # collector stalls if zero calls

preprocessCodeBlock = (collector, codeBlock, adapter) ->
  assertions = []
  code = _.map codeBlock.source.split('\n'), (line, i) ->
    if assertion = createAssertion(collector, adapter, line, codeBlock.line + i + 1)
      assertions.push(assertion)
      adapter.logicFor('__docunit', assertion, assertions.length - 1)
    else
      line
  .join('\n')

  {code, assertions}

createAssertion = (collecter, adapter, line, lineNumber) ->
  if expectation = adapter.assertionFor(line)
    collectee = collecter()
    assertion = _.extend {}, expectation,
      lineNumber: lineNumber
      finishedRunning: false
      __done: (er) ->
        assertion.finishedRunning = true
        delete assertion.__done
        collectee(er, assertion)
