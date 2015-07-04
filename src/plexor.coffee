

require './support/globals'
require './support/matchers'
t = require './support/tokens'
{ findStore, once } = require './support/flux'

module.exports = ->

  should = (matcher, arg) ->
    "store.getAll().should.#{matcher.split(' ').join '.'}(#{arg})"

  @Given t.x("(#{t.var}) (#{t.arg})"), (name, value) ->
    name = name[1..]
    value = value[1...-1]
    @[name] = value

  @When t.x("([^@]*) (#{t.arg})"), (action, arg, done) ->
    { store, actions } = findStore @store
    once store, @on, -> done()
    arg = arg[1...-1]
    actions[action] arg

  @Then t.x(t.should), (matcher)->
    { store } = findStore @store
    store.getAll().should.be.empty()
#    eval should matcher

  @Then t.x("#{t.should}:"), (matcher, value) ->
    { store } = findStore @store
    value = _.zipObject value.raw()
    eval should matcher, 'value'