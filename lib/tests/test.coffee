Db = require '../database'
db = Db ':memory:'

tasks = [
	{text: 'test1'},
	{text: 'test3'},
	{text: 'test2'}
]

db.saveTasks tasks, (err) ->
	if err?
		console.log err
		return

	db.getTasks (err, tasks) ->
		console.log task for task in tasks
