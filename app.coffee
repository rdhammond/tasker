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
				'maxcdn.bootstrapcdn.com'
			]

app.use express.static('public')

app.get '/', (req, res) ->
	res.render 'home'

app.listen config.port, () ->
	console.log "Running on port #{config.port}"
