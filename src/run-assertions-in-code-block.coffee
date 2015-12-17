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
      """
      var __docunitAssertion = {};
      __docunitAssertion.expected = #{assertion.expected};
      __docunitAssertion.actual = #{assertion.actual};
      __docunitAssertion.passed = true;
      try {
        __docunit.assert.deepEqual(__docunitAssertion.actual, __docunitAssertion.expected);
      } catch(e) {
        __docunitAssertion.passed = false;
      }
      __docunit.assertions.push(__docunitAssertion);
      """
    else
      line
  .join('\n')

