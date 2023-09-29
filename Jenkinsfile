pipeline {
    agent any 
    tools {
        maven 'slave'
    }
    environment {
        remote1="ec2-user@65.2.184.100"
    }
    parameters {
        string (name:'Env', defaultValue:'Linux', description:'Linux Env')
        booleanParametrs(name:'polar', defaultValue:true, description:'conditional')
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
                    sh 'mvn compile'
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
                        sh "scp -o StrictHostKeyChecking=no server_cfg.sh ${remote1}:/home/ec2-user/"
                        sh "ssh -o StrictHostKeyChecking=no ${remote1} 'bash ~/server_cfg.sh'"
                    }

                }
                
            }
        }
    }
}