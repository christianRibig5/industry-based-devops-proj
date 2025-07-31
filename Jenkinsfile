pipeline {
    agent any
    
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/christianRibig5/industry-based-devops-proj.git'
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Deploy to Docker') {
            steps {
                sh '''
                ansible-playbook -i inventory.ini deploy-docker.yml
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
		echo "Current Dir: $(pwd)"
		echo "Available files:"
		ls -la
                ansible-playbook -i inventory.ini ${WORKSPACE}/deploy-k8s.yml
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}

