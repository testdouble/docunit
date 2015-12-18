_ = require('lodash')
vm = require('vm')
assert = require('assert')

GLOBALS = { Buffer, __dirname, __filename, clearInterval, clearTimeout, console,
            exports, global, module, process, require, setInterval, setTimeout }

module.exports = (codeBlock, adapter) ->
  sandbox = vm.createContext _.extend {}, GLOBALS,
    __docunit:
      assertions: []
      assert: assert

  vm.runInContext(preprocessCodeBlock(codeBlock, adapter), sandbox)
  sandbox.__docunit.assertions

preprocessCodeBlock = (codeBlock, adapter) ->
  _.map codeBlock.source.split('\n'), (line, i) ->
    if assertion = adapter.assertionFor(line)
      adapter.logicFor('__docunit', assertion, codeBlock.line + i + 1)
    else
      line
  .join('\n')

