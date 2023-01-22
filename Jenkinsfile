 pipeline{
     agent any
     
     tools {
         maven 'maven.3.8.6'
     }
     options {
  buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
  timestamps()
}
 triggers {
  pollSCM '* * * * *'
}


     parameters {
  choice choices: ['development', 'master', 'qa', 'uat'], description: 'select the branch', name: 'BranchName'
  string defaultValue: 'Lokeshreddy', description: 'change the PersonName', name: 'PersonName'
}
     stages{
         
         stage('checkoutcode'){
             steps{
                 sendslacknotifications('STARTED')
                 git branch: "${params.BranchName}", credentialsId: 'a3cc0927-12e4-4932-8f53-fb3e92fe4e8b', url: 'https://github.com/lokeshsgithub/maven-employee-web-application.git'
             }
         }
         stage('Run test and Build'){
             steps{
                 parallel(
                 RunTestCases:{
                sh "mvn clean test"
                },
                Build:{
                    sh "echo The person name is: $PersonName"
                    sh "mvn clean package"
                }
            )
            }
         }
         
     }//stages closed
 }//pipeline closed
 //slack notification function
def sendslacknotifications(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESS'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    colorName = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESS') {
    colorName = 'GREEN'
    colorCode = '#00FF00'
  } else {
    colorName = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary,channel:'#citibank-projects' )
}
