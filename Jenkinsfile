pipeline {
    agent any 
    tools {
        maven 'slave'
    }
    environment {
        remote1="ec2-user@65.0.110.118"
       // remote1="ec2-user@65.0.110.118"
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
                        withCredentials([usernamePassword(credentialsId: 'ec43b4ea-f666-415c-aabd-ccde3a4b1e38', passwordVariable: 'pwd', usernameVariable: 'usr')]) {
                            sh "scp -o StrictHostKeyChecking=no server_cfg.sh ${remote1}:/home/ec2-user/"
                            sh "ssh -o StrictHostKeyChecking=no ${remote1} 'bash ~/server_cfg.sh ${REPONAME} ${BUILD_NUMBER}'"
                            sh "ssh -o StrictHostKeyChecking=no ${remote1} 'bash docker login -u ${usr} ${pwd}'"
                        //    sh "ssh -o StrictHostKeyChecking=no ${remote1} 'bash docker push ${REPONAME}:${BUILD_NUMBER}"
    
                        }
                        
                        
                    }

                }
                
            }
        }
        //stage ('DEPLOY') {
        //    steps {
        //        sshagent(['remoteuser2']) {
        //            script {
        //                echo "DEPLOY STAGE at ${params.Env}"
        //                sh "scp -o StrictHostKeyChecking=no server_cfg.sh ${remote1}:/home/ec2-user/"
        //                sh "ssh -o StrictHostKeyChecking=no ${remote1} 'bash ~/server_cfg.sh'"
        //            }

        //        }
                
        //    }
    }
    
}