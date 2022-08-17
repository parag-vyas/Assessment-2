pipeline {
     agent any
	tools{
		maven "mvn"
	}
     
    stages{
        stage("clone the Repo") {
            steps {
                    sh "git clone https://github.com/parag-vyas/Assessment-2.git"
                   }
            }
	stage ("Build Code") {
		steps{
		    dir("/var/lib/jenkins/workspace/project2/Assessment-2")
			sh "mvn clean install"
                	sh 'mvn package' 
                    }
	}
        stage ("Build Image") {
            steps{
                dir("/var/lib/jenkins/workspace/project2/Assessment-2"){
                    sh 'docker build -t 24121986/ubuntu1 .' 
                    }
                }
            }
        stage ("Push the Image to Dockerhub") {
            steps {
            script{
                withCredentials([string(credentialsId: '24121986', variable: 'dockerhub')]) {
                sh 'docker login -u 24121986 -p${dockerhub}'   
                   }
                sh "docker push 24121986/ubuntu1"
                }
            }
        }
		stage ("Deploying to kubernetes") {
			steps {
			dir ("/var/lib/jenkins/workspace/project2/Assessment-2") {
			    sshagent(['58af5faf-0a89-4fc7-8f62-c825e50f68b5']) {
                    sh "scp -o StrictHostKeyChecking=no deploy.yml ec2-user@3.84.86.236:"
                    sh "ssh ec2-user@3.84.86.236 kubectl delete -f ."
                    script{
                        try{
                            sh "ssh ec2-user@3.84.86.236 kubectl apply -f ."
                        }catch(error){
                            sh "ssh ec2-user@3.84.86.236 kubectl create -f ."
                        }
                        }
                    }
                }
			}
        }
    }
}

