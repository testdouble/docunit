module.exports =
  # Note: to sneak in real-comment-comments you can do:
  #
  # lalala /// three things don't match
  #
  # or
  #
  # foo // 'bar' // this last comment-comment won't match
  assertionFor: (line) ->
    if !/^\/\//.test(line) && matches = line.match(/^(.*?)\/\/([^\/]*)/)
      actual: matches[1]
      expected: matches[2]

  logicFor: (globalName, assertion, lineNumber) ->
    """
    var __docunitAssertion = {};
    __docunitAssertion.lineNumber = #{lineNumber};
    __docunitAssertion.expected = #{assertion.expected};
    __docunitAssertion.actual = #{assertion.actual};
    __docunitAssertion.passed = true;
    try {
      #{globalName}.assert.deepEqual(__docunitAssertion.actual, __docunitAssertion.expected);
    } catch(e) {
      __docunitAssertion.passed = false;
    }
    #{globalName}.assertions.push(__docunitAssertion);
    """

