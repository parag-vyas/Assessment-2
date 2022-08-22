pipeline{
    agent any
	tools{
		maven "mvn"
	}
	stages {
	stage ("Build Code") {
		steps{
			checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '49596370-6250-4efd-9841-62d4d23f7716', url: 'https://github.com/parag-vyas/Assessment-2.git']]])
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
	stage('File transfer into minikube server') {

            steps {

            sh 'scp -r /var/lib/jenkins/workspace/jenkins-docker/* ubuntu@172.31.23.198:/home/ubuntu/project'

            }        

    }
	stage('Login into minikube server and run helm chart') {
            steps {
		sh """
		 ssh ubuntu@172.31.23.198 << EOF
		       cd parag
		    helm install myfirstchart tomcat
		exit
		<< EOF		
    		}
	}
}
