coffee    = require 'gulp-coffee'
coveralls = require 'gulp-coveralls'
gulp      = require 'gulp'
gutil     = require 'gulp-util'
istanbul  = require 'gulp-istanbul'
mocha     = require 'gulp-mocha'
path      = require 'path'
uglify    = require 'gulp-uglifyjs'
verb      = require 'gulp-verb'

destDir = path.dirname require('./package.json').main

gulp.task 'docs', ->
  # sadly, verb is broken
  gulp.src ['.verbrc.md']
    .pipe verb dest:'README.md'
    .pipe gulp.dest './'

gulp.task 'test', ['compile'], ->
  gulp.src './dist/*.js'
  .pipe istanbul()
  .on 'finish',->
    gulp.src './test/*.{js,coffee,litcoffee}', read:false
    .pipe mocha
      reporter: 'spec'
      compilers: 'coffee:coffee-script/register'
    .pipe istanbul.writeReports()

gulp.task 'coveralls', ['test'], ->
  gulp.src 'coverage/**/lcov.info'
  .pipe coveralls()

gulp.task 'compile',->
  gulp.src './src/*.{coffee,litcoffee}'
    .pipe coffee bare:false
      .on 'error', gutil.log
    .pipe gulp.dest destDir
    .pipe uglify(path.basename(require('./package.json').main).replace('.js','.min.js'))
    .pipe gulp.dest destDir

gulp.task 'default', ['compile','test', 'coveralls'] #, 'docs'
