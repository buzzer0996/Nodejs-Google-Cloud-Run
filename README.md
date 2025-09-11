# 🚀 Deploy Node.js Application to Google Cloud Run using Terraform & GitHub Actions

This project demonstrates how to **deploy a sample Node.js application** on **Google Cloud Run** using:

- **Terraform** → for infrastructure provisioning
- **GitHub Actions** → for CI/CD automation
- **Google Artifact Registry (GAR)** → for container image storage
- **GoDaddy** → for custom domain mapping

The pipeline covers the full cycle from **code commit** → **Docker build** → **security scans** → **deploy to google cloud run** → **domain mapping with godaddy**.

### 📂 Project Structure:

```
├── .github/
│   └── workflows/
│       └── deploy.yml
├── terraform/
│   ├── provider.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── variables.tfvars
│   └── output.tf
├── Dockerfile
├── app.js
├── package.json
└── README.md

```

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🏗️ Tech Stack:

- **Node.js**
- **Docker**
- **Terraform**
- **Google Cloud Run**
- **GitHub Actions**
- **Trivy (Aqua Security)**

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### ⚙️ Prerequisites:

Before running this project, make sure you have:

- A **Google Cloud Project**
- **Google Artifact Registry** created (for storing Docker images)
- **Service Account JSON key** with required roles (Artifact Registry Admin, Cloud Run Admin, IAM Admin, Service Account User, etc.)
- **Terraform installed** (v1.9.5 or higher if running locally)
- **GoDaddy Domain** (optional, for custom domain mapping)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🔑 GitHub Secrets:

Set the following secrets in your repository (`Settings → Secrets and variables → Actions`):

- `GOOGLE_APPLICATION_CREDENTIALS` → contents of your GCP service account JSON key

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🛠️ GitHub Actions Workflow:

The pipeline (`.github/workflows/deploy.yml`) performs the following steps:

**1. Checkout** → Pulls source code from the repo

**2. Trivy FS Scan** → Scans source code for vulnerabilities

**3. Build & Push Docker Image** → Builds Docker image & pushes to Google Artifact Registry

**4. Trivy Docker Scan** → Scans built image for vulnerabilities

**5. Deploy with Terraform** → Provisions Cloud Run service & deploys the container


------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🚀 Deployment Process:

1. Push changes to the `main` branch → GitHub Actions pipeline kicks off automatically

2. Docker image is built, scanned, and pushed to GAR

3. Terraform provisions or updates the Cloud Run service with the new image

4. Once deployed, Cloud Run will provide a service URL

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 🌐 Custom Domain with GoDaddy:

### 🔗 Steps to Link GoDaddy Domain with Google Cloud Run

### 1. Prepare Your Cloud Run Service

- Make sure your service is deployed and working at the Cloud Run URL (which you already have ✅).
- Your service should allow unauthenticated access if you want the public to reach it.

### 2. Verify Domain Ownership in Google Cloud:

1. Go to **Google Cloud Console** → **Cloud Run** → Open **Cloud Run Service** → **Networking** → **Custom Domains**.
2. Click **"Add Mapping"**.
3. Choose your Cloud Run service.
4. Enter your domain (like myapp.com or app.myapp.com).
5. It will generate a TXT record that you must add to your GoDaddy DNS to prove ownership.

### 3. Update DNS Records in GoDaddy:

1. Log in to **GoDaddy** → go to **My Products** → select your domain → **DNS Management**.
2. Add the records that Google Cloud asks for:
   - **TXT Record** (for verification).
   - Once verified, you’ll need to add `A records` or   `AAAA records`   (Google provides them during the mapping).
  
### 4. Provision SSL (HTTPS):

- After DNS is configured, Google Cloud will automatically request and attach a free SSL certificate for your domain.
- Cloud Run handles HTTPS automatically — no need to buy SSL from GoDaddy.
- It may take 15–60 minutes for DNS propagation, Propagation time may vary, so don’t worry if it doesn’t work instantly.


### 5. Access Your App:

- Once the certificate is ready and DNS has propagated, you’ll be able to open:
  👉 `https://yourdomainname.com` 
