express = require 'express'
bodyParser = require 'body-parser'
TaskList = require './TaskList'
router = express.Router()

router.get '/', (req, res, next) ->
	TaskList.getTasks()
	.then (tasks) -> res.render 'home', {tasks}
	.catch (err) -> next err

module.exports = router
