pipeline {
     agent any
	tools{
		maven "mvn"
	}
     
	stages {
	stage ("Build Code") {
		steps{
		dir("/var/lib/jenkins/workspace/project2/Assessment-2"){
			sh "rm -rf *"
			sh "git clone https://github.com/parag-vyas/Assessment-2.git" 
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
		sshagent(['kubectl']) {
                   
		    sh "scp -r tomcat ec2-user@3.82.119.151:"	
			
                    sh " ssh ec2-user@3.82.119.151 helm install mychart1 tomcat"
                   

                    
                }
			}
        }
    }
}
}
