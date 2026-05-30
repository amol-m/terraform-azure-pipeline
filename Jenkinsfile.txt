pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                echo 'Code checked out successfully'
            }
        }
        stage('Terraform Version') {
            steps {
                sh 'terraform version'
            }
        }
        stage('Azure CLI Version') {
            steps {
                sh 'az version'
            }
        }
    }
}