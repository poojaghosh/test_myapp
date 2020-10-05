pipeline {
  agent any
  tools {
        maven 'Maven'
        jdk 'JDK'
        dockerTool 'Docker'
    }
    stages {
        stage ('Initialize') {
            steps {
                bat '''
                    echo "PATH = ${PATH}"
					echo 'this **********'
                    echo "M2_HOME = ${M2_HOME}"
					'''
            }
        }

        stage ('Build Maven') {
            steps {
                //bat 'mvn -Dmaven.test.failure.ignore=true install' 
				bat 'mvn clean package'
            }
          }
		stage('Build Docker image') {
		  agent { label 'master' }
		  	  
         steps {
			bat 'docker build -t chika1984/myapp:4.0.0 .'
			}
		}	
		stage('Push Docker image') {
		 steps {
			withCredentials([string(credentialsId: 'Docker-Hub1', variable: 'DockerHubPwd')]) {
            bat "docker login -u chika1984 -p ${DockerHubPwd}"
			}
			bat 'docker push chika1984/myapp:4.0.0'
		} 	
		}
         //stage('Run Docker image on PROD') {
		 //steps {
		 //sshagent(['production']) {
		 //sh "ssh -o StrictHostKeyChecking=no ubuntu@13.233.100.158 ${dockerRun}"
         //def dockerRun = 'docker run -p 8080:8080 -d -name myapp chika1984/myapp::3.0.0'		 
		 //}
        // sh "docker run -p 22:8080 -d -name myapp chika1984/myapp:3.0.0" 
//}
//}
}
}