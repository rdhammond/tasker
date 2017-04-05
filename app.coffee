mongoose = require 'mongoose'
express = require 'express'
csp = require 'express-csp'
morgan = require 'morgan'
homeRouter = require './lib/home-router'
taskRouter = require './lib/task-router'
config = require './config'

mongoose.Promise = global.Promise
mongoose.connect config.mongo

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

app.use express.static 'public'
app.use morgan 'tiny'
app.use '/', homeRouter
app.use '/tasks', taskRouter

app.listen config.port, () ->
	console.log "Running on port #{config.port}"
