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
			dist:
				options:
					sourceMap: yes
				files: [{
					expand: yes
					cwd: 'javascript'
					src: '**/*.js'
					dest: 'public/js'
					rename: (dst, src) ->
						src = src.replace '.js', '.min.js'
						return "#{dst}/#{src}"
				}]
		watch:
			sass:
				files: ['sass/**/*.scss']
				tasks: ['sass']
			javascript:
				files: ['javascript/**/*.js']
				tasks: ['uglify']

	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-sassjs'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-watch'

	grunt.registerTask 'default', ['clean', 'sass', 'uglify']
