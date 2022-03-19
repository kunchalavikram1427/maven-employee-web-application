node{
    
    def mavenHome = tool name: "maven3.8.4"
   
   jacoco deltaBranchCoverage: '080', deltaClassCoverage: '080', deltaComplexityCoverage: '080', deltaInstructionCoverage: '080', deltaLineCoverage: '080', deltaMethodCoverage: '080', maximumBranchCoverage: '80', maximumClassCoverage: '80', maximumComplexityCoverage: '80', maximumInstructionCoverage: '80', maximumLineCoverage: '80', maximumMethodCoverage: '80', minimumBranchCoverage: '080', minimumClassCoverage: '080', minimumComplexityCoverage: '080', minimumInstructionCoverage: '80', minimumLineCoverage: '080', minimumMethodCoverage: '080' 
    
    stage('git Checkout'){
      git branch: 'development', credentialsId: '8eafc813-44a7-4f04-8b8f-aa6f1a3b4123', url: 'https://github.com/SUDHANSU-088/maven-employee-web-application.git'  
    }

    stage('Build maven'){
        sh "${mavenHome}/bin/mvn clean package"
        //mavenHome=/var/lib/jenkins/tools/hudson.**/maven3.8.4/
    }
    
    stage('CodeQuaklityMAnagementSONARQUBE'){
        sh "${mavenHome}/bin/mvn sonar:sonar"
    }
    
    stage('artifactREpoNExus'){
         sh "${mavenHome}/bin/mvn deploy"
    }
    stage('deployTomcat'){
        sshagent(['35995341-da3c-45bc-bf22-c1eab36ddc16']) {
        sh "scp -o StrictHostKeyChecking=no target/employee-application.war ec2-user@52.66.146.36:/opt/apache-tomcat-9.0.60/webapps"
}
    
    }

}
