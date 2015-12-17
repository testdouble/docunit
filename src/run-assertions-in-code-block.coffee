_ = require('lodash')
vm = require('vm')
assert = require('assert')

module.exports = (codeBlock, adapter) ->
  sandbox =
    __docunit:
      assertions: []
      assert: assert

  vm.runInNewContext(preprocessCodeBlock(codeBlock, adapter), sandbox)
  sandbox.__docunit.assertions

preprocessCodeBlock = (codeBlock, adapter) ->
  _.map codeBlock.split('\n'), (line, i) ->
    if assertion = adapter.assertionFor(line)
      adapter.logicFor('__docunit', assertion)
    else
      line
  .join('\n')

