markdownToAst = require('markdown-to-ast').parse
traverse = require('traverse')

module.exports = (markdown) ->
  traverse(markdownToAst(markdown)).reduce (acc, node) ->
    if node?.type == 'CodeBlock'
      acc.push
        source: node.value,
        line: node.loc.start.line,
        lang: node.lang
    acc
  , []


