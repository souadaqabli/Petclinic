# 🚀 Complete DevOps Project: CI/CD with Spring Petclinic

This project demonstrates the implementation of a complete DevOps architecture (GitOps) to deploy a Java Spring Boot application on Kubernetes.

## 🏗️ Project Architecture
1. **Code & Versioning:** GitHub
2. **CI (Continuous Integration):** Jenkins (Maven Compilation, SonarQube Analysis, Docker Build)
3. **Image Registry:** DockerHub (`souads20/petclinic`)
4. **CD (Continuous Deployment):** ArgoCD (GitOps Methodology)
5. **Infrastructure:** Local Kubernetes Cluster (Minikube)
6. **Observability:** Grafana & Prometheus

---

## 🛠️ Included Configuration Files
* `Jenkinsfile`: The complete continuous integration pipeline.
* `Dockerfile`: Uses Tomcat 9 to host the `.war` archive.
* `k8s/deployment.yaml`: Kubernetes files (Deployment & NodePort Service) automatically updated by Jenkins.

---

## 💻 Useful Commands (Cheat Sheet)

Here are all the necessary commands to manage the environment locally:

### 1. Minikube Cluster Management
Start or stop the cluster:
```bash
minikube start
minikube stop
