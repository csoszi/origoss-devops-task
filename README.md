Origoss DevOps Task

This repository contains a full end-to-end implementation of the Origoss DevOps technical task.
The solution covers:
Simple HTTP server
Dockerization
CI pipeline
Kubernetes deployment

Terraform deployment using the Kubernetes provider

The goal is to provide a minimal, clean, and reproducible setup without unnecessary dependencies.

Repository Structure
.
├── app/
│   └── main.go               # Simple Go HTTP server
├── Dockerfile                # Multi-stage Docker build
├── k8s/
│   ├── deployment.yaml       # Kubernetes Deployment
│   └── service.yaml          # Kubernetes Service
├── terraform/
│   ├── main.tf               # Terraform config using Kubernetes provider
│   └── variables.tf
└── .github/workflows/
    └── ci.yaml               # CI pipeline to build & push Docker image

1️. Simple HTTP Server

A minimal Go application that returns "Hello, World!" at /.

Run locally
cd app
go run main.go


Visit:

http://localhost:8080

2. Dockerization

The Go app is containerized using a multi-stage build to keep the final image small.

Build the image
docker build -t <yourname>/hello-world .

Run the container
docker run -p 8080:8080 <yourname>/hello-world

3️. CI Pipeline (GitHub Actions)

A GitHub Actions workflow automatically:

Builds the Docker image

Logs in to Docker Hub

Pushes the image

Pipeline file: .github/workflows/ci.yaml

To activate it:

Create Docker Hub repository

Add secrets to your GitHub repo:

Secret Name	Description
DOCKERHUB_USERNAME	Your Docker Hub username
DOCKERHUB_TOKEN	Docker Hub access token

On every push to main, a new image is built and uploaded.

4️. Kubernetes Deployment

The Kubernetes manifests are located in k8s/.

deployment.yaml – deploys the app using the Docker image from CI

service.yaml – exposes the app via NodePort

Apply manually
kubectl apply -f k8s/


Check the deployment:

kubectl get pods
kubectl get svc

5️. Terraform Deployment

Terraform configuration located in terraform/ deploys the same Kubernetes manifests into a cluster using the Kubernetes provider.

Requirements

A running Kubernetes cluster (e.g. KIND, Minikube, or cloud provider)

kubectl configured (~/.kube/config present)

Terraform ≥ 1.3

Deploy using Terraform
cd terraform
terraform init
terraform apply


Terraform will:

Connect to the existing Kubernetes cluster

Apply Deployment + Service resources

Manage state declaratively

To remove:

terraform destroy

Testing

After deployment, verify:

kubectl get pods
kubectl port-forward svc/hello-world 8080:80


Then visit:

http://localhost:8080
