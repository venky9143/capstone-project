# Capstone Project - EKS Deployment

## Overview
This project demonstrates deploying a **full-stack application** on **AWS EKS** with monitoring, observability. The application is deployed via **Helm**, monitored using **Prometheus & Grafana**.

---

## Architecture
- **AWS EKS Cluster** with Bottlerocket nodes
- **NodePort Service** for app exposure
- **Add-ons Installed**:
  - Amazon VPC CNI
  - CoreDNS
  - Metrics Server
  - CloudWatch Observability
  - EKS Pod Identity Agent
- **Monitoring Stack**:
  - Prometheus for metrics collection
  - Grafana for dashboards

---

## Cluster Details

| Resource | Details |
|----------|---------|
| Cluster Name | capstone-cluster |
| Kubernetes Version | v1.33.1 |
| Node OS | Bottlerocket |
| Node Public IPs | [List your node IPs] |
| Subnets | Private subnets only |
| Endpoint Access | Public & Private |

---

## Application Deployment

- **Namespace:** `capstone`  
- **Helm Release:** `capstone-capstone-chart`  
- **Pods:** 2 replicas (running)  
- **Service Type:** NodePort  
- **NodePort:** 30343  
- **Internal Endpoints:** 172.31.78.152, 172.31.78.157
- <img width="1920" height="912" alt="capstoneproject" src="https://github.com/user-attachments/assets/d7907f69-aeee-49f2-ba65-7216310ee806" />


---

## Monitoring & Observability

- **Prometheus:** Scrapes metrics from the app and cluster  
- **Grafana:** Dashboards to visualize CPU, memory, and pod metrics  
- **CloudWatch:** Container Insights (degraded status, needs configuration)
- <img width="1920" height="3658" alt="monitoring" src="https://github.com/user-attachments/assets/a532bf39-8958-4768-a8b7-c8570539b1e3" />

- <img width="1920" height="3658" alt="capstone" src="https://github.com/user-attachments/assets/8d327191-aa6c-4417-91e7-e522ac8eeca9" />


---

## Optional Features

- **Istio Service Mesh:** Sidecar injection enabled  
- **Ingress:** Istio Ingress Controller deployed (LoadBalancer optional)  

---

## Setup Instructions

### 1. Clone the repo
```bash
git clone 
cd capstone-project
2. Create EKS Cluster (Terraform)
cd terraform
terraform init
terraform apply
3. Deploy Helm Charts
cd helm/capstone-chart
helm install capstone-capstone-chart .
4. Install Monitoring Stack
# Prometheus & Grafana
helm install prometheus prometheus-community/prometheus
helm install grafana grafana/grafana


Accessing the Application

NodePort: http://<node-public-ip>:30343
Grafana: http://<grafana-ip>:3000
Default login: admin/admin
Prometheus: http://<prometheus-ip>:9090


