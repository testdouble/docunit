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
      assertions = _(markdowns).map (markdown) ->
        _(findCodeBlocksInMarkdown(markdown.toString())).map (codeBlock) ->
          runAssertionsInCodeBlock(codeBlock, jsAdapter)
        .flatten().value()
      .flatten().value()

      cb(null,
        passed: _.all(assertions, (a) -> a.passed)
        files: files
        assertions: assertions
      )


