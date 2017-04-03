module.exports = (grunt) ->
	grunt.initConfig
		clean: [
			'public/**/*'
		]
		sass:
			dist:
				sourceMap: yes
				files:
					'public/css/styles.css': 'sass/styles.scss'
		uglify:
			options:
				sourceMap: true
			build:
				cwd: 'javascript'
				src: '**/*.js'
				dest: 'public/js'

	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-sassjs'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.registerTask 'default', ['clean', 'sass', 'uglify']
