pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        DOCKER_IMAGE_NAME = 'timagx/nodeapp'
        AZURE_CLIENT_ID = credentials('azure-client-id')
        AZURE_CLIENT_SECRET = credentials('azure-client-secret')
        AZURE_TENANT_ID = credentials('azure-tenant-id')
        AKS_CLUSTER_NAME = 'myAKSCluster-gboi'
        AKS_RESOURCE_GROUP = 'rg-gboi'
        KUBE_CONFIG_PATH = '/var/lib/jenkins/workspace/.kube/config'
    }

    tools {
        git 'Default' // Ensure this matches the name in Global Tool Configuration
    }

    stages {
 /*       stage('Install Kubectl') {
            steps {
                sh '''
                if ! command -v kubectl &> /dev/null
                then
                    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
                    chmod +x ./kubectl
                    sudo mv ./kubectl /usr/local/bin/kubectl
                fi
                '''
            }
        }*/
        stage('Checkout') {
            steps {
                // Checkout the code from Git repository
                 git branch: 'main', credentialsId: 'dockerhub-credentials', url: 'https://github.com/TimAGX/Shopping-cartt.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${DOCKER_IMAGE_NAME}:v1")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image("${DOCKER_IMAGE_NAME}:v1").push('v1')
                    }
                }
            }
        }
        stage('Set up Kubernetes Context') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'azure-client-id', variable: 'AZURE_CLIENT_ID'),
                                     string(credentialsId: 'azure-client-secret', variable: 'AZURE_CLIENT_SECRET'),
                                     string(credentialsId: 'azure-tenant-id', variable: 'AZURE_TENANT_ID')]) {
                        sh """
                        az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
                        az aks get-credentials --name ${AKS_CLUSTER_NAME} --resource-group ${AKS_RESOURCE_GROUP} --file ${KUBE_CONFIG_PATH}
                        """
                    }
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                script {
                    withEnv(["KUBECONFIG=${KUBE_CONFIG_PATH}"]) {
                        sh """
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}