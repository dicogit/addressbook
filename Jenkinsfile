pipeline {
    agent none
    tools {
        jdk 'java8'
        maven 'slave-mvn'
    }
    //parameters { 
      //   string(name:'LIVE_ENV', defaultValue:'platform', description: 'pipe lie testing') 
      // booleanParam(name: 'C_BUILD', defaultValue: true, description: 'pass execute')
      //choice(name: 'VERSION', choices: ['RHCE_8', 'RHCE_9', 'RHCE_10'], description: 'Environment Version')
      //}
    environment {
        slave2='ec2-user@3.110.176.197'
    }
    stages {
        stage ('Compile') {
            agent any
            steps {
                script {
                    echo "Compile the code"
                //    echo "${params.LIVE_ENV}"
                    sh "mvn compile"
                }
            }
        }
        stage ('Unittest') {
            agent { label 'slave1'}
           // when {
           //         expression {
           //                 params.C_BUILD == true
            //            }
            //        }
            steps {
                script {
                    
                    echo "Test the code"
                    sh "mvn test"
                }
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage ('Package') {
            agent any
           // agent { label 'slave1'}
           // input {
           //     message "Choose Version"
           //     ok "Version chosen"
           //     parameters {
           //         choice(name:"version" ,choices:[10,20,30])
            //    }
            steps {
                script {
                    sshagent(['AGENT_ID']) {
                        echo "Package the code"
                   // echo "Platform VERSION : ${params.VERSION}"
                        sh "scp -o StrictHostKeyChecking=no server_cfg.sh ${slave2}:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ${slave2} 'bash ~/server_cfg.sh'"
                    }
                    
                }
            }
        }
    }
}