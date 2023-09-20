pipeline {
    agent any
    parameters { 
        string(name:'LIVE_ENV', defaultValue:'platform', description: 'pipe lie testing') 
        booleanParam(name: 'C_BUILD', defaultValue: true, description: 'pass execute')
        choice(name: 'VERSION', choices: ['RHCE_8', 'RHCE_9', 'RHCE_10'], description: 'Environment Version')
        }.
    stages {
        stage ('Compile') {
            steps {
                script {
                    echo "Compile the code"
                    echo "${params.LIVE_ENV}"
                }
            }
        }
        stage ('Unittest') {
            when {
                    ecpression {
                            params.C_BUILD == true
                        }
                    }
            steps {
                script {
                    
                    echo "Test the code"
                }
            }
        }
        stage ('Package') {
            steps {
                script {
                    echo "Package the code"
                    echo "Platform VERSION : ${params.VERSION}"
                }
            }
        }
    }
}