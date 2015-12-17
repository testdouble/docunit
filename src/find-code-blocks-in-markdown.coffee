markdownToAst = require('markdown-to-ast').parse
traverse = require('traverse')

module.exports = (markdown) ->
  console.log "parsing: #{markdown}"
  traverse(markdownToAst(markdown)).reduce (acc, node) ->
    acc.push(node.value) if node?.type == "CodeBlock"
    acc
  , []


