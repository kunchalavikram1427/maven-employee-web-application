pipeline {
    agent {
        docker {
            label 'linux01'
            image 'maven:3.8.3-adoptopenjdk-11'
        }
    }
    stages {
        stage('Code Build') {
            steps {
                sh "mvn clean package"
            }
        }
    }
}
