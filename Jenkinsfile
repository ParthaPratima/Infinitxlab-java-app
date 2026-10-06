pipeline {
  agent any

  //environment {
   // MVN_HOME = '/usr/share/maven'
  //}

  stages {
    stage('Clone') {
      steps {
        git url: 'https://github.com/Soumyajit-Rout/webapp.git'
      }
    }

    stage('Build') {
      steps {
        sh 'mvn clean install'
      }
    }

    stage('Upload to Nexus') {
      steps {
        sh 'mvn deploy'
      }
    }

    stage('Deploy to Tomcat') {
      steps {
        //sshagent(['tomcat-ssh-key']) {
          sh """
          scp /var/lib/jenkins/workspace/app-deploy/target/*.war ubuntu@172.31.84.222:/home/ubuntu/tomcat8/webapps/
          """
        }
    }
  }
}
