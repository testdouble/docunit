glob = require('glob')
fs = require('fs')
async = require('async')
_ = require('lodash')

findCodeBlocksInMarkdown = require('./find-code-blocks-in-markdown')
runAssertionsInCodeBlock = require('./run-assertions-in-code-block')
jsAdapter = require('./adapters/js')

# Takes a path, a glob, or an array of paths and globs and a callback that
# reports success or failure
module.exports = (pattern, cb) ->
  glob pattern, (er, files) ->
    return cb(er) if er?
    async.map files, fs.readFile, (er, markdowns) ->
      return cb(er) if er?
      async.map markdowns, (markdown, cb2) ->
        async.map findCodeBlocksInMarkdown(markdown.toString()),  (codeBlock, cb3) ->
          runAssertionsInCodeBlock(codeBlock, jsAdapter, cb3)
        , cb2
      , (er, assertions) ->
        return cb(er) if er?
        assertions = _.flatten(assertions, true)
        cb(null,
          passed: _.all(assertions, (a) -> a.result.passed)
          files: files
          assertions: assertions
        )


