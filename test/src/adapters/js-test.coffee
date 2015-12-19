describe 'jsAdapter', ->
  Given -> @subject = require('../../../src/adapters/js')
  describe '.assertionFor', ->
    Then -> @subject.assertionFor("lalala /// three is fine") == undefined
    Then -> @subject.assertionFor('// a comment') == undefined
    Then -> expect(@subject.assertionFor("foo // 'bar' // baz")).to.deep.equal
      expected: "'bar'"
      actual: "foo"
    Then -> expect(@subject.assertionFor("foo // '4/9'")).to.deep.equal
      expected: "'4/9'"
      actual: "foo"



