module.exports =
  # Note: to sneak in real-comment-comments you can do:
  #
  # lalala /// three things don't match
  #
  # or
  #
  # foo // 'bar' // this last comment-comment won't match
  assertionFor: (line) ->
    return if /^\/\//.test(line)
    [actual, expected] = line.split('//')
    if actual? && expected? && expected[0] != '/'
      actual: actual.trim()
      expected: expected.trim()

  logicFor: (globalName, assertion, assertionIndex) ->
    """
    try {
      var __docunitAssertion = #{globalName}.assertions[#{assertionIndex}]
      __docunitAssertion.result = {
        passed: true,
        actual: #{assertion.actual},
        expected: #{assertion.expected}
      };
      try {
        #{globalName}.assert.deepEqual(__docunitAssertion.result.actual, __docunitAssertion.result.expected);
      } catch(e) {
        __docunitAssertion.result.passed = false;
      }
      __docunitAssertion.__done(null)
    } catch(e) {
      __docunitAssertion.__done(e)
    }
    """

