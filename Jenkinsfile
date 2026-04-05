
pipeline {
    agent any

    environment {
        DOCKER_IMAGE  = "your-dockerhub-username/shopeasy-python"
        APP_SERVER    = "ubuntu@<app-ec2-public-ip>"
        CONTAINER_PORT = "5000"
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/prabhavpss01-dot/ShopEasy-Product-Listing-App.git'
                    credentialsId: 'github-creds'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip3 install -r requirements.txt'
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        docker build -t $DOCKER_IMAGE:latest .
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push $DOCKER_IMAGE:latest
                    '''
                }
            }
        }

        stage('Deploy to App EC2') {
            steps {
                sshagent(['app-ec2-ssh-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no $APP_SERVER "
                            docker pull $DOCKER_IMAGE:latest &&
                            docker stop shopeasy || true &&
                            docker rm shopeasy || true &&
                            docker run -d \
                                --name shopeasy \
                                -p 5000:5000 \
                                --restart always \
                                $DOCKER_IMAGE:latest
                        "
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment successful! App is live.'
        }
        failure {
            echo 'Pipeline failed. Check the console output.'
        }
    }
}
