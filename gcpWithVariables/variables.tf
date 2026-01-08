variable "project" {
  description = "The GCP project ID to deploy resources into"
  type        = string
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

variable "credentials" {
  default = "terraform-sa-key.json"
}

variable "tags" {
  default = ["terraform-test"]
}

variable "name" {
  default = "terraform-instance"
}

variable "machine_type" {
  default = "f1-micro"
}
