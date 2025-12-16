pipeline {
    agent any

    environment {
        INVENTORY = "ansible/inventory.txt"
    }

    stages {

        stage('Verify Connectivity') {
            steps {
                sh '''
                ansible ec2 -i $INVENTORY -m ping
                '''
            }
        }

        stage('Check Jenkins Status') {
            steps {
                sh '''
                ansible ec2 -i $INVENTORY -m shell -a "systemctl is-active jenkins"
                '''
                }

        }

        stage('System Health Check') {
            steps {
                sh '''
                ansible ec2 -i $INVENTORY -m shell -a "df -h"
                ansible ec2 -i $INVENTORY -m shell -a "uptime"
                '''
            }
        }

    }

    post {
        success {
            echo "Jenkins Monitoring Pipeline Successful"
        }
        failure {
            echo "Jenkins Monitoring Pipeline Failed"
        }
    }
}
