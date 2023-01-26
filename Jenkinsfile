@Library('lokisharedlibs') _
pipeline{
     agent any
     
     tools {
         maven 'maven3.8.7'
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
                 sendSlackNotifications('STARTED')
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
                 sh "echo The person name is: ${PersonName}"
                    sh "mvn clean package"
                }
            )
            }
         }
         
     }//stages closed
 post{
  success {
   sendSlackNotifications(currentBuild.result)
  }
  failure {
   sendSlackNotifications(currentBuild.result)
  }
 }
 }//pipeline closed
 
