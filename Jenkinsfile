pipeline {
    agent none
    tools {
        jdk 'java8'
        maven 'slave-mvn'
    }
    parameters { 
        string(name:'LIVE_ENV', defaultValue:'platform', description: 'pipe lie testing') 
        booleanParam(name: 'C_BUILD', defaultValue: true, description: 'pass execute')
        choice(name: 'VERSION', choices: ['RHCE_8', 'RHCE_9', 'RHCE_10'], description: 'Environment Version')
        }
    stages {
        stage ('Compile') {
            agent any
            steps {
                script {
                    echo "Compile the code"
                    echo "${params.LIVE_ENV}"
                    sh "mvn compile"
                }
            }
        }
        stage ('Unittest') {
            agent any
            when {
                    expression {
                            params.C_BUILD == true
                        }
                    }
            steps {
                script {
                    
                    echo "Test the code"
                    sh "mvn test"
                }
            }
        }
        stage ('Package') {
            agent { label 'slave1'}
            input {
                message "Choose Version"
                ok "Version chosen"
                parameters {
                    choice(name:"version" ,choices:[10,20,30])
                }
            }
            steps {
                script {
                    echo "Package the code"
                    echo "Platform VERSION : ${params.VERSION}"
                    sh "mvn package"
                }
            }
        }
    }
}