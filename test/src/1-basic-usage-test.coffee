describe 'basic docunit', ->
  beforeEach -> @subject = require('../../src/docunit')
  it '1-hello-world.md', (done) ->
    @subject 'test/fixtures/1-hello-world.md', (er, results) ->
      expect(results.passed).to.equal(true)
      expect(results.assertions.length).to.equal(1)
      assertion = results.assertions[0]
      expect(assertion.actual).to.equal('hello, world')
      expect(assertion.expected).to.equal('hello, world')
      expect(assertion.passed).to.equal(true)
      done(er)


