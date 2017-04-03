express = require 'express'
csp = require 'express-csp'
Db = require './lib/database'
homeRouter = require './lib/home-router'
config = require './config'

db = Db 'tasks.db'

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

app.use (req, res, next) ->
	req.db = db
	next()

app.use '/', homeRouter

app.listen config.port, () ->
	console.log "Running on port #{config.port}"
