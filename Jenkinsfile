pipeline {
    agent any

    environment {
        CONTROLLER = "ubuntu@Î172.31.75.15"
        PROJECT_DIR = "/home/ubuntu/test-project"
       
    }

    stages {

        stage('Verify Connectivity from Controller') {
            steps {
                sh """
                ssh -o StrictHostKeyChecking=no ${CONTROLLER} \
                'cd ${PROJECT_DIR} && ansible ec2 -i inventory.txt -m ping'
                """
            }
        }

        stage('Check Jenkins Status from Controller') {
            steps {
                sh """
                ssh ${CONTROLLER} \
                'cd ${PROJECT_DIR} && ansible ec2 -i inventory.txt -m shell -a "systemctl is-active jenkins"'
                """
            }
        }

        stage('System Health Check') {
            steps {
                sh """
                ssh ${CONTROLLER} \
                'cd ${PROJECT_DIR} && ansible ec2 -i inventory.txt -m shell -a "df -h"'
                ssh ${CONTROLLER} \
                'cd ${PROJECT_DIR} && ansible ec2 -i inventory.txt -m shell -a "uptime"'
                """
            }
        }
    }

    post {
        success {
            echo "✅ Jenkins used Ansible from Controller successfully"
        }
        failure {
            echo "❌ Jenkins → Controller → Ansible flow failed"
        }
    }
}
