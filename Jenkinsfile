pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        githubNotify (status: 'PENDING', context: 'Build', description: 'Building Jekyll site.')
        slackSend (message: "${currentBuild.fullDisplayName} Build started (<${env.BUILD_URL}|Open>)", color: '#37b787')
        sh 'gem install execjs'
        sh 'bundle install'
        sh 'bundle exec jekyll build'
      }
      post {
        success {
          githubNotify (status: 'SUCCESS', context: 'Build', description: 'Jekyll build complete!')
          slackSend (message: "${currentBuild.fullDisplayName} Success after ${currentBuild.durationString.minus(' and counting')} (<${env.BUILD_URL}|Open>)", color: '#37b787')
        }
        failure {
          githubNotify (status: 'FAILURE', context: 'Build', description: 'Jekyll build failed!')
          slackSend (message: "${currentBuild.fullDisplayName} Failed after ${currentBuild.durationString.minus(' and counting')} (<${env.BUILD_URL}|Open>)", color: '#ff0000')
        }
      }
    }
    stage('Deploy') {
      when{
        branch 'master'
      }
      steps {
        githubNotify (status: 'PENDING', context: 'Deploy', description: 'Deploying site.')
        slackSend (message: "${currentBuild.fullDisplayName} Deploy started (<${env.BUILD_URL}|Open>)", color: '#37b787')
        sh 'wd deploy --to=production'
      }
      post {
        success {
          githubNotify (status: 'SUCCESS', context: 'Deploy', description: 'Deploy complete!')
          slackSend (message: "${currentBuild.fullDisplayName} Success after ${currentBuild.durationString.minus(' and counting')} (<${env.BUILD_URL}|Open>)", color: '#37b787')
        }
        failure {
          githubNotify (status: 'FAILURE', context: 'Deploy', description: 'Deploy failed!')
          slackSend (message: "${currentBuild.fullDisplayName} Failed after ${currentBuild.durationString.minus(' and counting')} (<${env.BUILD_URL}|Open>)", color: '#ff0000')
        }
      }
    }
  }
}
