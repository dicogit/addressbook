pipeline {
    agent none
	//tools {
	//	jdk 'java8'
	//	maven 'slave-mvn'
	//}
	//environment {
	//	slave2_ip='ec2-user@3.109.108.101'
	//}
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
        //stage ('Test') {
		//	agent {label 'slave1'}
        //    when {
        //            expression {
        //                params.polar == true
        //            }
        //        }
        //    steps {
        //        script {
        //            echo "Welcome to Test stage"
		//			sh 'mvn test'
        //        }
		//	            
        //    }
		//	post {
		//		always {
		//			junit 'target/surefire-reports/*.xml'
		//		}
		//	
		//	}
        //}
        //stage ('Package') {
		//	agent any
		//	steps {
        //        script {
		//			sshagent(['slave2-agent']) {
        //            echo "Welcome to Package stage"
        //            //echo "The Version is ${params.poll}"
		//			sh "scp -o StrictHostKeyChecking=no server_cfg.sh ${slave2_ip}:/home/ec2-user"
		//			sh "ssh -o StrictHostKeyChecking=no ${slave2_ip} 'bash ~/server_cfg.sh'"
		//			}
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
		stage ('Package2') {
			agent any
				steps {
					script {
						echo "Welcome to Deploy stage"
					  sh 'mvn package'
				}
					
			}
        }
    }
}