# Terraform + GCP Setup Summary

This document summarizes everything completed so far to successfully provision infrastructure on Google Cloud Platform (GCP) using Terraform.

---

## 1. Project Setup

* **Project ID:** `terraform-test-483707`
* **Region:** `us-central1`
* **Zone:** `us-central1-c`
* **Working Directory:**

  ```
  /Users/nitish/Desktop/nitish/terraform/gcp
  ```

---

## 2. Terraform Configuration (`main.tf`)

```hcl
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project     = "terraform-test-483707"
  region      = "us-central1"
  zone        = "us-central1-c"
  credentials = file("terraform-sa-key.json")
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = true
}
```

---

## 3. Google Cloud Authentication (Service Account)

### Why Service Account?

* User-based OAuth (ADC) caused permission and browser issues
* Service Accounts are **production-standard** for Terraform and CI/CD

### Steps Completed

1. Set correct project:

   ```bash
   gcloud config set project terraform-test-483707
   ```

2. Created service account:

   ```bash
   gcloud iam service-accounts create terraform-sa \
     --description="Terraform Service Account" \
     --display-name="terraform-sa"
   ```

3. Granted permissions:

   ```bash
   gcloud projects add-iam-policy-binding terraform-test-483707 \
     --member="serviceAccount:terraform-sa@terraform-test-483707.iam.gserviceaccount.com" \
     --role="roles/editor"
   ```

4. Created service account key:

   ```bash
   gcloud iam service-accounts keys create terraform-sa-key.json \
     --iam-account=terraform-sa@terraform-test-483707.iam.gserviceaccount.com
   ```

5. Moved key to Terraform directory and ignored it:

   ```bash
   mv ~/terraform-sa-key.json /Users/nitish/Desktop/nitish/terraform/gcp/
   echo "terraform-sa-key.json" >> .gitignore
   ```

---

## 4. Terraform Commands Executed

```bash
terraform init -reconfigure
terraform fmt
terraform validate
terraform plan
terraform apply
```

* `terraform init` → provider initialized successfully
* `terraform plan` → showed **1 resource to add**
* `terraform apply` → attempted resource creation

---

## 5. GCP API Enablement

### Issue Encountered

Terraform failed with:

```
Compute Engine API has not been used or is disabled
```

### Fix

Enabled Compute Engine API:

```bash
gcloud services enable compute.googleapis.com
```

This is required for:

* VPC networks
* Subnets
* Firewalls
* VM instances

---

## 6. Successful Result

* Terraform plan executed successfully
* VPC network **`terraform-network`** created
* Managed fully by Terraform state

Verification methods:

### CLI

```bash
gcloud compute networks list
```

### UI

* Google Cloud Console → **VPC network → VPC networks**

---

## 7. Key Learnings

* Difference between `gcloud auth login` and ADC
* Why Service Accounts are preferred for Terraform
* IAM permissions vs API enablement
* Terraform lifecycle: init → plan → apply
* Debugging real-world GCP + Terraform issues

---

## 8. Next Steps (Planned)

* Add custom subnet
* Add firewall rules (SSH / HTTP)
* Create VM instance
* Introduce variables and `tfvars`
* Split into Terraform modules

---

✅ This setup is **production-aligned** and forms a strong Terraform + GCP foundation.
