pipeline {
     agent any
	tools{
		maven "mvn"
	}
     
	stages {
	stage ("Build Code") {
		steps{
		dir("/var/lib/jenkins/workspace/project2/Assessment-2"){
			checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '49596370-6250-4efd-9841-62d4d23f7716', url: 'https://github.com/parag-vyas/Assessment-2.git']]])
		    	sh "mvn install"
                	sh 'mvn package' 
                    }
		}
	}
        stage ("Build Image") {
            steps{
                dir("/var/lib/jenkins/workspace/project2/Assessment-2"){
                    sh 'docker build -t 24121986/assessment2 .' 
                    }
                }
            }
        stage ("Push the Image to Dockerhub") {
            steps {
            script{
                withCredentials([string(credentialsId: '24121986', variable: 'dockerhub')]) {
                sh 'docker login -u 24121986 -p${dockerhub}'   
                   }
                sh "docker push 24121986/assessment2"
                }
            }
        }
		stage ("Deploying to kubernetes") {
			steps {
			dir ("/var/lib/jenkins/workspace/project2/Assessment-2") {
			    sshagent(['58af5faf-0a89-4fc7-8f62-c825e50f68b5']) {
                    sh "scp -o StrictHostKeyChecking=no deploy.yml ec2-user@3.94.80.84:"
                    sh "ssh ec2-user@3.94.80.84 kubectl"
                    sh """

                     ssh ec2-user@3.94.80.84 << EOF

                     helm install mychart2 tomcat

        exit

        << EOF

        """
                }
			}
        }
    }
}
}
