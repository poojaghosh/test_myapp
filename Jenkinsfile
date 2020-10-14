def dockerRun = "docker run -p 8085:8080 -d --name T3App chika1984/myapp:5.0.0"
pipeline {
  agent any
  tools {
        maven 'maven'
        jdk 'jdk'
        //dockerTool 'Docker'
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
					echo 'this **********'
                    echo "M2_HOME = ${M2_HOME}"
					'''
            }
        }

        stage ('Build Maven') {
            steps {
                //bat 'mvn -Dmaven.test.failure.ignore=true install' 
				sh 'mvn clean package'
            }
          }
		stage('Build Docker image') {
		  agent { label 'master' }
		  	  
         steps {
			sh 'docker build -t chika1984/myapp:5.0.0 .'
			}
		}	
		stage('Push Docker image') {
		agent { label 'master' }
		 steps {
			withCredentials([string(credentialsId: 'DockerHub', variable: 'dockerHub')]) {
            sh "docker login -u chika1984 -p ${dockerHub}"
			}
			sh 'docker push chika1984/myapp:5.0.0'
		} 	
		}
         stage('Run Docker image on Stage') {
		 //agent { label 'staging' }
		 steps {
		 sshagent(['staging']) {
		 sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.37.84 ${dockerRun}"
         }
    }
}
}
}