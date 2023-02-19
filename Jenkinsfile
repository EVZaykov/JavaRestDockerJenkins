pipeline{
	agent any
    environment {
        SECRET_TOKEN = credentials('secret-token')
	    CUCUMBER_TAGS = "--tags ${TAGS}"
    }
	stages {
		stage('Run Test'){
			steps{
				bat "mvn clean test -DUSERNAME=${USERNAME} -DPASSWORD=${PASSWORD} -DENV=${ENVIRONMENT} -Dcucumber.options=\"${CUCUMBER_TAGS}\""
			}
		}
	}
	post{
		always{
			script {
              allure([
                includeProperties: false,
                jdk: '',
                properties: [],
                reportBuildPolicy: 'ALWAYS',
                results: [[path: 'target/allure-results']]
              ])
            }
			//emailext (to:  "${Email}", replyTo: "", subject: "Email Report from - '${env.JOB_NAME}' ", body: "Email Report from - '${env.JOB_NAME}'  <br> http://localhost:8080/job/${env.JOB_NAME}/${env.BUILD_NUMBER}/allure/ <br> http://localhost:8080/job/${env.JOB_NAME}/${env.BUILD_NUMBER}/", mimeType: 'text/html');
		}
	}
}
