Project Name: Shopping Cart Application.

Project Description: This project focuses on automating the deployment of infrastructure components on Azure using Terraform and implementing a CI/CD pipeline with Jenkins. The goal is to create a scalable and maintainable infrastructure setup that allows for efficient application deployment and updates.

The project involves the following key steps:

Infrastructure as Code: Utilize Terraform to provision 5 Virtual machine with remote access capabilities and an AKS cluster with 3 worker nodes. The infrastructure state will be managed remotely using azure blob

Jenkins Server Setup: Configure one of the Virtual machine as a Jenkins server, which will serve as the central hub for the CI/CD pipeline. Jenkins will be responsible for automating the build, test, and deployment processes.

Containerization with Docker: Containerize the application code using Docker to ensure portability and consistency across different environments. The Dockerized application will be made accessible externally to enable seamless deployment.

CI/CD Pipeline: Implement a CI/CD pipeline in Jenkins that integrates with the GitHub repository hosting the project code. This pipeline will automate the build, test, and deployment of the application to the Kubernetes cluster created in step 1. Docker registry will be used to store the Docker images, and Nginx Ingress Controller will be set up to manage traffic to the deployed services.

Monitoring Stack: Set up a monitoring stack using Prometheus and Grafana to monitor the health and performance of the Kubernetes cluster. This monitoring stack will provide valuable insights into the deployed services, enabling proactive issue detection and resolution.

The project objective is to achieve infrastructure automation, efficient deployment, and continuous integration and delivery, resulting in a streamlined and scalable development process.

SETUP STEPS

Provision the resources 

```bash
terraform init
terraform validate
terraform plan
terraform apply
```


Install Java

```bash
sudo apt update
sudo apt install openjdk-17-jre
```

Verify Java is Installed

java -version
Now, you can proceed with installing Jenkins

```bash
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```

Docker Slave Configuration
Run the below command to Install Docker

```bash
sudo apt update
sudo apt install docker.io
```

Grant Jenkins user and Ubuntu user permission to docker deamon.

```bash
sudo su - 
usermod -aG docker jenkins
usermod -aG docker ubuntu
systemctl restart docker
sudo systemctl restart jenkins
```

Once you are done with the above steps, it is better to restart Jenkins.

```bash
http://<ec2-instance-public-ip>:8080/restart
```

The docker agent configuration is now successful.

Add Azure and Docker Credentials to Jenkins
To connect Jenkins with Azure, you need to add Azure credentials to Jenkins:

Install Azure CLI on the Jenkins Server:

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

```bash
az login
```

Generate a Service Principal: Use the Azure CLI to generate a service principal, which Jenkins will use to interact with Azure.

```bash
az ad sp create-for-rbac --name "jenkins-sp" --role contributor \
--scopes /subscriptions/<subscription-id>/resourceGroups/<resource-group> \
--sdk-auth
```

This command will output a JSON object containing the credentials you'll need. Save this output securely.

Add Azure Credentials in Jenkins:

Go to Jenkins Dashboard > Manage Jenkins > Manage Credentials.

Install kubectl on the Jenkins agent by running:

```bash
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

Ensure kubectl is Configured for AKS

You need to ensure that your kubectl is configured to use your AKS cluster.

```sh
az aks get-credentials --resource-group <your-resource-group> --name <your-cluster-name>
```

