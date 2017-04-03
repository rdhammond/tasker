express = require 'express'
router = express.Router()

router.get '/', (req, res, next) ->
	req.db.getTasks (err, tasks) ->
		return next err if err?
		res.render 'home', {tasks}

module.exports = router
