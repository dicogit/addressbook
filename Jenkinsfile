pipeline {
    agent any
    tools {
        jdk 'java8'
    }
    parameters { 
        string(name:'LIVE_ENV', defaultValue:'platform', description: 'pipe lie testing') 
        booleanParam(name: 'C_BUILD', defaultValue: true, description: 'pass execute')
        choice(name: 'VERSION', choices: ['RHCE_8', 'RHCE_9', 'RHCE_10'], description: 'Environment Version')
        }
    stages {
        stage ('Compile') {
            steps {
                script {
                    echo "Compile the code"
                    echo "${params.LIVE_ENV}"
                    sh "mvn compile"
                }
            }
        }
        stage ('Unittest') {
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