1. Application Layer: Simple HTTP Server (Go)

The solution starts with a minimal Go web server (main.go). Its responsibilities are:

Listen on port 8080

Handle requests to /

Return a static text response:
“Hello, World!”

Log the requests (useful for debugging in containers)

This keeps the application simple, ensuring the rest of the DevOps pipeline is the focus.

2. Containerization Layer: Dockerfile

The Dockerfile uses a multi-stage build:

Builder stage

Compiles the Go application

Produces a statically linked binary

Final stage (Alpine)

Copies the binary

Runs it in a lightweight, secure environment

This ensures:

The final image is small

The build is reproducible

No unnecessary dependencies are shipped

You can run the container locally the same way Kubernetes runs it:

docker build -t <user>/hello-world-server .
docker run -p 8080:8080 <user>/hello-world-server

3. Automation Layer: CI/CD Pipeline (GitHub Actions)

The workflow file .github/workflows/release.yml automates:

Check out code

Build Docker image

Log in to Docker Hub using GitHub Secrets

Tag image:

latest

<commit-SHA> (immutable)

Push both tags to Docker Hub

The pipeline triggers on:

Push to main

Pull requests to main

This creates a reliable release pipeline where every merge produces:

A new Docker image

A permanent tag referencing the exact code version

This is crucial for Terraform and Kubernetes so they always deploy a known-good version.

4. Deployment Layer: Kubernetes Manifests

Even though Terraform deploys everything, the raw Kubernetes YAML files (k8s_deployment.yaml, k8s_service.yaml) define the desired state of the application:

Deployment

3 replicas

Uses the image pushed by GitHub Actions

Resource requests/limits for scheduling

Probes can be added if needed

Service

Exposes port 8080

Makes the app reachable inside (or outside) the cluster

How the cluster is provisioned

For local testing, Docker Desktop Kubernetes was used:

Enables a single-node K8s cluster

Works out of the box with Terraform

No cloud account required

You can verify the deployment manually:

kubectl get pods -n origoss

5. Infrastructure as Code Layer: Terraform Deployment

Terraform is used to fully automate applying the Kubernetes manifests.

Key components:

Kubernetes provider

Configured to use the local kubeconfig:

provider "kubernetes" {
  config_path = "~/.kube/config"
}

Namespace creation

Terraform creates the namespace before applying manifests.

Deploying YAML with kubernetes_manifest

Instead of directly applying static YAML files, Terraform:

Loads template files

Injects the image tag dynamically

Applies them through the Kubernetes API

This ensures:

Version consistency between image + Kubernetes

Declarative provisioning

No manual kubectl apply required

Applying the deployment
terraform init
terraform apply -var="image_tag=$(git rev-parse HEAD)"


Terraform will:

Connect to the cluster

Create namespace

Deploy Deployment + Service

Pull the exact image tagged by the CI pipeline

This tightly integrates the workflow across:

Git → Docker → CI → Registry → Terraform → Kubernetes

6. Validation Layer: Testing the Running Application

Once deployed, you can test the running service by port-forwarding:

kubectl port-forward deployment/hello-world-server-deployment 8080:8080 -n origoss
curl http://localhost:8080


Expected output:

Hello, World!


This confirms that:

Kubernetes pulled the correct image

Pods are running correctly

Networking is set up properly

Terraform applied configuration accurately

Every component is automated and reproducible.

Summary

This solution demonstrates:

Application development (Go)

Containerization (Docker)

CI automation (GitHub Actions)

Kubernetes orchestration (YAML)

Infrastructure-as-code (Terraform)

Immutable release workflow (commit-SHA image tagging)

It gives a complete, professional DevOps pipeline that covers all stages from code to deployment — exactly aligned with the assignment requirements.
