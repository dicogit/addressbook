pipeline {
    agent none
	tools {
		maven 'slave-mvn'
	}
    //parameters{
    //    string(name:'Env',defaultValue:'LINUX',description:'New Project')
    //    booleanParam(name:'polar',defaultValue:true,description:'Polarization')
    //    choice(name:'poll',choices:[5.5,6.0,6.5],description:'choose version')
    //}
    stages {
        //stage ('Build') {
        //    steps {
        //        script {
        //            echo "Welcome to Build stage of ${params.Env}"
		//			  sh 'mvn compile'
        //        }
        //        
        //    }
        //}
        stage ('Test') {
			agent {label 'slave1'}
            //when {
            //        expression {
            //            params.polar == true
            //        }
            //    }
            steps {
                script {
                    echo "Welcome to Test stage"
					sh 'mvn test'
                }
			            
            }
			post {
				always {
					junit '/target/surefire-reports/*.xml'
				}
			
			}
        }
        //stage ('Package') {
        //    steps {
        //        script {
        //            echo "Welcome to Package stage"
        //            //echo "The Version is ${params.poll}"
        //        }
        //        
        //    }
        //}
        //stage ('Deploy') {
        //    input {
        //        message 'Approve'
        //        ok 'Yes'
        //    }
        //    steps {
        //        script {
        //            echo "Welcome to Deploy stage"
        //        }
        //        
        //    }
        //}
    }
}