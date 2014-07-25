assert = require 'assert'
generate_string = require('./helpers').generate_string
post_json = require('./helpers').post_json
get_json = require('./helpers').get_json
App_Runner = require('./helpers').App_Runner
ae = assert.equal
			
describe '/api | ', () ->

	before (cb) ->
		@server = new App_Runner
		@server.start () ->
			cb()

	beforeEach (cb) ->
		cb()

	after (cb) ->
		@server.stop () ->
			cb()

	it 'start', (cb) ->
		get_json "/api", (status, data) ->
			ae 200, status
			cb()

