# Copied from https://github.com/TorchlightSoftware/accumulator
# Copyright Torchlight Software <info@torchlightsoftware.com> and distributed
# under the MIT license
#
# (copied inline b/c it doesn't pre-compile its CoffeeScript, impacting performance)
module.exports = accumulator = (done) ->
  counter = 0
  error = null
  results = []

  ->
    counter++
    called = false

    (err, result) ->
      return if error
      return if called

      called = true
      if err
        error = err
        return done(err, results)

      results.push(result) unless result == accumulator.SKIP_RESULT
      if --counter is 0
        done(null, results)


accumulator.SKIP_RESULT = {}
