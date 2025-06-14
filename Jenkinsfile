pipeline {
    agent any

    environment {
        IMAGE_VERSION = "1.${BUILD_NUMBER}"              // Dynamic version for image
        DOCKER_IMAGE = "convertisseur:${IMAGE_VERSION}"  // Image name
        DOCKER_CONTAINER = "convertisseur"               // Container name
    }

    stages {

        stage("Checkout") {
            steps {
                git branch: 'master', url: 'https://github.com/EmmanuelTakor/ConverterApp.git'
            }
        }

        stage("Test") {
            steps {
                echo "Running tests (to be implemented)"
            }
        }

        stage("Build Docker Image") {
            steps {
                script {
                    sh "docker build -t $DOCKER_IMAGE ."
                }
            }
        }

        stage("Push image to Docker Hub") {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'credential-id', 
                        usernameVariable: 'DOCKER_USER', 
                        passwordVariable: 'DOCKER_PASSWORD'
                    )]) {
                        sh """
                        echo 'Logging into Docker Hub...'
                        docker login -u ${DOCKER_USER} -p ${DOCKER_PASSWORD}
                        docker tag $DOCKER_IMAGE ${DOCKER_USER}/$DOCKER_IMAGE
                        docker push ${DOCKER_USER}/$DOCKER_IMAGE
                        """
                    }
                }
            }
        }

        stage("Deploy") {
            steps {
                script {
                    sh """
                    echo 'Deploying container...'
                    docker container stop $DOCKER_CONTAINER || true
                    docker container rm $DOCKER_CONTAINER || true
                    docker container run -d --name $DOCKER_CONTAINER -p 8080:80 $DOCKER_IMAGE
                    """
                }
            }
        }
    }
}

    post {
        always {
            echo "Cleaning up..."
            sh "docker system prune -f"
        }
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}