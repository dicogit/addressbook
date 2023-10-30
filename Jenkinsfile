pipeline {
    agent any 
    tools {
        maven 'slave'
    }
    environment {
        remote1="ec2-user@3.110.208.200"
        //remote2="ec2-user@43.204.107.107"
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
                            sh "ssh -o StrictHostKeyChecking=no ${remote1} 'sudo docker login -u ${docr} -p ${dpwd}'"
                            sh "ssh -o StrictHostKeyChecking=no ${remote1} 'sudo docker push ${REPONAME}:${BUILD_NUMBER}'"
    
                        }
                                    
                    }

                }
                
            }
        }
        stage ("TF Creating EC2") {
            environment {
                AWS_ACCESS_KEY_ID=credentials("AWS_ACCESS_KEY_ID")
                AWS_SECRET_ACCESS_KEY=credentials("AWS_SECRET_ACCESS_KEY")
            }
            steps {
                script {
                    dir ("terraform") {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                        EC2_PUBLIC_IP=sh(returnStdout: true, script: "terraform output ectype").trim()
                        echo "EC2_PUBLIC_IP: '${EC2_PUBLIC_IP}'"
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
                sshagent(['remoteuser']) {
                    script {
                        echo "DEPLOY STAGE at ${params.Env}"
                        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dpwd', usernameVariable: 'docr')]) { 
                            sh "ssh -o StrictHostKeyChecking=no ec2-user@${EC2_PUBLIC_IP} 'sudo yum install docker -y'"
                            sh "ssh -o StrictHostKeyChecking=no ec2-user@${EC2_PUBLIC_IP} 'sudo systemctl start docker'"
                            sh "ssh -o StrictHostKeyChecking=no ec2-user@${EC2_PUBLIC_IP} 'sudo docker login -u ${docr} -p ${dpwd}'"
                            sh "ssh -o StrictHostKeyChecking=no ec2-user@${EC2_PUBLIC_IP} 'sudo docker pull ${REPONAME}:${BUILD_NUMBER}'"
                            sh "ssh -o StrictHostKeyChecking=no ec2-user@${EC2_PUBLIC_IP} 'sudo docker run -itd -P ${REPONAME}:${BUILD_NUMBER}'"

                        }
                        
                    }

                }
                
            }
        }
    }
    
}