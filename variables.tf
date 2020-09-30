variable "os_image" {
  description = "Default operating system image for compute instance."
  type        = string
  default     = "UBUNTU_18_64"
}

variable "flavor" {
  description = "Default instance size."
  type        = string
  default     = "BL2_2X4X100"
}

variable "domain" {
  description = "Domain for compute instance."
  type        = string
  default     = "cdetesting.com"
}

variable "datacenter" {
  description = "Datacenter where instance will be deployed."
  type        = string
  default     = "dal12"
}

variable "ssh_key" {
  description = "Classic IaaS ssh key to add to compute instance."
  type        = string
  default     = "ryan_hyperion_2020"
}

variable "hostname" {
  description = "Hostname for instance."
  type        = string
  default     = "us-south-cos"
}

variable "private_icos_endpoint" {
  type = string
  description = "The ICOS endpoint. Default is us-south regional endpoint."
  default = "s3.private.us-south.cloud-object-storage.appdomain.cloud"
}