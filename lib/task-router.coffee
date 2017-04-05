express = require 'express'
bodyParser = require 'body-parser'
TaskList = require './TaskList'
router = express.Router()

json = bodyParser.json()

router.post '/', json, (req, res, next) ->
	TaskList.add req.body
	.then (task) -> res.json task
	.catch (err) -> next err

# ** PICK UP HERE: Allow position changes
#
router.put '/:id', json, (req, res, next) ->
	req.body._id = req.params.id

	TaskList.update req.body
	.then () -> res.sendStatus 200
	.catch (err) -> next err

router.delete '/', json, (req, res, next) ->
	TaskList.deleteMany req.body
	.then () -> res.sendStatus 200
	.catch (err) -> next err

module.exports = router
