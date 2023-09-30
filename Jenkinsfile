pipeline {
    agent any 
    tools {
        maven 'slave'
    }
    environment {
        remote1="ec2-user@65.0.110.118"
        remote2="ec2-user@43.205.125.106"
        REPONAME='devopsdr/pvt'
    }
    parameters {
        string (name:'Env', defaultValue:'Linux', description:'Linux Env')
        booleanParam(name:'polar', defaultValue:true, description:'conditional')
        choice(name:'poll', choices:[7,8,9], description:'selection')
    }
    stages {
        stage ('COMPILE') {
            steps {
                script {
                    echo "COMPILE STAGE at ${params.Env}"
                    sh 'mvn compile'
                }
            }
        }
        stage ('TEST') {
            when {
                expression {
                    params.polar == true
                }
            }
            steps {
                script {
                    echo "TEST STAGE at ${params.Env}"
                    sh 'mvn test'
                }
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage ('PACKAGE') {
            steps {
                sshagent(['remoteuser']) {
                    script {
                        echo "PACKAGE STAGE at ${params.Env}"
                        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dpwd', usernameVariable: 'docr')]) {
                            sh "scp -o StrictHostKeyChecking=no server_cfg.sh ${remote1}:/home/ec2-user/"
                            sh "ssh -o StrictHostKeyChecking=no ${remote1} 'bash ~/server_cfg.sh ${REPONAME} ${BUILD_NUMBER}'"
                            sh "ssh ${remote1} sudo docker login -u ${docr} -p ${dpwd}"
                            sh "ssh -o StrictHostKeyChecking=no ${remote1} 'bash sudo docker push ${REPONAME}:${BUILD_NUMBER}"
    
                        }
                                    
                    }

                }
                
            }
        }
        stage ('DEPLOY') {
            input {
                message 'Run Addressbook Application'
                ok 'Approved'
                parameters {
                    choice(name:'Version', choices:['V1','V2','V3'])
                }
            }
            steps {
                sshagent(['remoteuser2']) {
                    script {
                        echo "DEPLOY STAGE at ${params.Env}"
                        sh "ssh -o StrictHostKeyChecking=no ${remote2} 'bash sudo yum install docker -y'"
                        sh "ssh -o StrictHostKeyChecking=no ${remote2} 'bash sudo docker pull ${REPONAME}:${BUILD_NUMBER}'"
                        sh "ssh -o StrictHostKeyChecking=no ${remote2} 'bash sudo docker run -itd -P ${REPONAME}:${BUILD_NUMBER}'"
                    }

                }
                
            }
        }
    }
    
}