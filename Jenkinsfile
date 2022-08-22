pipeline {

     agent any

     

    stages{

        stage("clone the Repo") {

            steps {

                sh "git clone https://github.com/parag-vyas/assess.git"

                   }

            }

        stage ("Build Image") {

            steps{

                    sh 'docker build -t 24121986/ubuntu1 .' 


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

            dir ("/var/lib/jenkins/workspace/Project/assess") {

                sshagent(['58af5faf-0a89-4fc7-8f62-c825e50f68b5']) {

                    sh "scp -o StrictHostKeyChecking=no deploy.yml ec2-user@54.234.28.11:"

                    /** sh "ssh ec2-user@54.234.28.11 kubectl delete -f ." */                    

                    script{

                        try{

                            sh "ssh -o StrictHostKeyChecking=no ec2-user@54.234.28.11 kubectl apply -f ."

                        }catch(error){

                            sh "ssh ec2-user@54.234.28.11 kubectl create -f ."

                        }

                        }

                    }

                }

        }

        }

    }

}
