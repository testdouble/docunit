# docunit

[![Build Status](https://travis-ci.org/testdouble/docunit.svg)](https://travis-ci.org/testdouble/docunit)

There's nothing worse than a documented use of a library that doesn't actually
work the way the docs say it does. But because docs tend to be written at discrete
moments of a project's life, they're only validated at those particular moments—inevitably,
the behavior of the API will diverge and someone will need to carry the burden of
remembering to updathe docs.

Well, not anymore! `docunit` is a tool that checks the code blocks in your Markdown
files to ensure they actually do what they say they do.

## Install


$ npm install --save-dev docunit


### API

``` javascript
var docunit = require('docunit')

docunit('test/fixtures/1-hello-world.md', function(er, results){
  results.passed // true
  results.assertions.length // 1
  results.files // ['test/fixtures/1-hello-world.md']

  var assertion = results.assertions[0]
  assertion.lineNumber // 8
  assertion.actual // "greeting + ', world'"
  assertion.expected // "'hello, world'"
  assertion.result.passed // true
  assertion.result.actual // 'hello, world'
  assertion.result.expected // 'hello, world'
})
```


### CLI

**Warning: does not exist**


$ docunit "path/to/docs/**/*.md"
