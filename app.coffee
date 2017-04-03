express = require 'express'
csp = require 'express-csp'
homeRouter = require './lib/home-router'
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
app.use '/', homeRouter

app.listen config.port, () ->
	console.log "Running on port #{config.port}"
