sqlite = require 'sqlite3'
TransDb = require('sqlite3-transactions').TransactionDatabase

module.exports = (filename) ->
	db = new TransDb(
		new sqlite.Database filename ? 'tasks.db',
		sqlite.OPEN_READWRITE | sqlite.OPEN_CREATE
	)

	db.exec 'CREATE TABLE IF NOT EXISTS tasks (pos INT NOT NULL, description TEXT NOT NULL)'
	db.exec 'CREATE INDEX IF NOT EXISTS IX_pos ON tasks (pos)'
	db.exec 'VACUUM'

	return {
		getTasks: (cb) ->
			db.serialize () ->
				db.all 'SELECT rowid as id, pos, description FROM tasks ORDER BY pos', cb

		saveTasks: (tasks, cb) ->
			db.beginTransaction (err, trans) ->
				return cb err if err?
				trans.run 'DELETE FROM tasks'

				stmt = db.prepare 'INSERT INTO tasks (pos, description) VALUES($pos, $description)'
				for task, i in tasks
					stmt.run
						$pos: i
						$description: task.text

				trans.commit cb
	}
