pipeline {
    agent any

    environment {
        ARM_CLIENT_ID       = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET   = credentials('ARM_CLIENT_SECRET')
        ARM_TENANT_ID       = credentials('ARM_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                echo 'Code checked out successfully'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Approval') {
            steps {
                timeout(time: 15, unit: 'MINUTES') {
                    input message: 'Review plan. Approve to deploy to Azure?',
                          ok: 'Deploy'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    az login --service-principal \
                      -u $ARM_CLIENT_ID \
                      -p $ARM_CLIENT_SECRET \
                      --tenant $ARM_TENANT_ID

                    az group show \
                      --name jenkins-tf-rg \
                      --output table
                '''
            }
        }
    }

    post {
        success {
            echo 'Azure resources deployed successfully'
        }
        failure {
            echo 'Pipeline failed — check logs above'
        }
        always {
            cleanWs()
        }
    }
}