module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    coffee:
      compile:
        options:
          bare: true
          join: true
        files:
          'build/ImageAnime.js': ['src/*.coffee']

  grunt.loadNpmTasks('grunt-contrib-coffee')

  grunt.registerTask('default', ['coffee'])

