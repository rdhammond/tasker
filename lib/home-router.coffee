express = require 'express'
router = express.Router()

router.get '/', (req, res) ->
	# ** TODO
	res.render 'home',
		tasks: [
			{id: 1, text: 'Task 1'}
			{id: 2, text: 'Task 2'}
			{id: 3, text: 'Task 3'}
		]

module.exports = router
