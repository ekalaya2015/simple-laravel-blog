
pipeline {
  agent any
  stages {
    stage('error') {
      steps {
        git(url: 'https://github.com/ekalaya2015/simple-laravel-blog.git', branch: 'master')
      }
    }

    stage('build') {
      steps {
        sh 'composer update'
      }
    }

  }
}
