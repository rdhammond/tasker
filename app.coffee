express = require 'express'
csp = require 'express-csp'
config = require './config'

app = express()
app.set 'view engine', 'pug'
app.set 'views', "#{__dirname}/views"

csp.extend app,
	policy:
		directives:
			'script-src': [
				"'self'",
				"'unsafe-inline'",
				'ajax.googleapis.com',
				'maxcdn.bootstrapcdn.com',
				'cdnjs.cloudflare.com'
			]

app.use express.static('public')

app.get '/', (req, res) ->
	# ** TODO
	res.render 'home',
		tasks: [
			{id: 1, text: 'Task 1'}
			{id: 2, text: 'Task 2'}
			{id: 3, text: 'Task 3'}
		]

app.listen config.port, () ->
	console.log "Running on port #{config.port}"
