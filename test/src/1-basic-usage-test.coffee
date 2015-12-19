describe 'basic docunit', ->
  beforeEach -> @subject = require('../../src/docunit')
  it '1-hello-world.md', (done) ->
    @subject 'test/fixtures/1-hello-*.md', (er, results) ->
      expect(results.files).to.deep.equal(['test/fixtures/1-hello-world.md'])
      expect(results.passed).to.equal(true)
      expect(results.assertions.length).to.equal(1)
      assertion = results.assertions[0]
      expect(assertion.lineNumber).to.equal(8)
      expect(assertion.actual).to.equal('greeting + \', world\'')
      expect(assertion.expected).to.equal('\'hello, world\'')
      expect(assertion.result.actual).to.equal('hello, world')
      expect(assertion.result.expected).to.equal('hello, world')
      expect(assertion.result.passed).to.equal(true)
      done(er)

  it '2-has-a-few-tests-and-blocks.md', (done) ->
    @subject 'test/fixtures/2-has-a-few-tests-and-blocks.md', (er, results) ->
      expect(results.passed).to.equal(false)
      expect(results.assertions.length).to.equal(5)

      # assertion 1
      expect(results.assertions[0]).to.deep.equal
        actual: '21 * 2'
        expected: '42'
        lineNumber: 3
        finishedRunning: true
        result:
          passed: true
          actual: 42
          expected: 42

      # assertion 2
      expect(results.assertions[1]).to.deep.equal
        actual: 'lol.push(5)'
        expected: '1'
        lineNumber: 7
        finishedRunning: true
        result:
          passed: true
          actual: 1
          expected: 1

      # assertion 3
      expect(results.assertions[2]).to.deep.equal
        actual: "/hi/.test('hi')"
        expected: 'true'
        finishedRunning: true
        lineNumber: 9
        result:
          actual: true
          expected: true
          passed: true

      # assertion 4
      expect(results.assertions[3]).to.deep.equal
        actual: 'true'
        expected: 'false'
        finishedRunning: true
        lineNumber: 17
        result:
          actual: true
          expected: false
          passed: false

      # assertion 5
      expect(results.assertions[4]).to.deep.equal
        actual: 'undefined'
        expected: 'undefined'
        finishedRunning: true
        lineNumber: 18
        result:
          actual: undefined
          expected: undefined
          passed: true

      done(er)

  it '3-node-globals.md', (done) ->
    @subject 'test/fixtures/3-node-globals.md', (er, results) ->
      expect(results.passed).to.equal(true)
      done(er)
