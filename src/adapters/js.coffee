# Note: to sneak in real-comment-comments you can do:
#
# lalala /// three things don't match
#
# or
#
# foo // 'bar' // this last comment-comment won't match
module.exports =
  assertionFor: (line) ->
    if matches = line.match(/^([^\/]*)\/\/([^\/]*)/)
      actual: matches[1]
      expected: matches[2]
