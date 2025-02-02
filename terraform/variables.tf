variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "ssh_key_fingerprint" {
  description = "Your SSH key fingerprint from DigitalOcean"
  type        = string
}

