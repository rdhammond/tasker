mongoose = require 'mongoose'

findTask = (taskList, id) ->
	idStrs = (task._id.toString() for task in taskList.tasks)
	idStrs.indexOf id

taskListSchema = new mongoose.Schema
	tasks:
		default: []
		type: [{
			text:
				type: String
				required: yes
				minLength: 1
			done:
				type: Boolean
				required: yes
		}]

taskListSchema.statics.add = (newTask) ->
	return Promise.reject new Error 'No new task provided.' if not newTask?
	delete newTask._id

	this.findOneAndUpdate {}, {}, {setDefaultsOnInsert: yes, upsert: yes, new: yes}
	.then (taskList) ->
		taskList.tasks.push newTask
		taskList.save()
	.then (taskList) ->
		Promise.resolve taskList.tasks[taskList.tasks.length-1]

taskListSchema.statics.update = (newTask) ->
	return Promise.reject new Error 'No task info provided.' if not newTask?

	this.findOneAndUpdate {}, {}, {setDefaultsOnInsert: yes, upsert: yes, new: yes}
	.then (taskList) ->
		i = findTask taskList, newTask._id
		return Promise.reject new Error 'No task found with matching id.' if i < 0
		pos = newTask.pos ? i
		pos = 0 if pos < 0
		pos = taskList.tasks.length if pos >= taskList.tasks.length

		if pos isnt i
			oldTask = taskList.tasks[pos]
			taskList.tasks.set pos, newTask	
			taskList.tasks.set i, oldTask
		else
			taskList.tasks.set i, newTask

		taskList.save()

taskListSchema.statics.deleteMany = (ids) ->
	try
		ids = (mongoose.Types.ObjectId id for id in ids)
	catch err
		return Promise.reject err

	this.findOneAndUpdate {}, {}, {setDefaultOnInsert: yes, upsert: yes, new: yes}
	.then (taskList) ->
		taskList.tasks.pull id for id in ids
		taskList.save()

taskListSchema.statics.getTasks = () ->
	this.findOneAndUpdate {}, {}, {setDefaultsOnInsert: yes, upsert: yes, new: yes}
	.then (taskList) ->
		Promise.resolve taskList.tasks.toObject()

module.exports = mongoose.model 'TaskList', taskListSchema
