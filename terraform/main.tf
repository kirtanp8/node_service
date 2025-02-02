terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}


resource "digitalocean_droplet" "node_server" {
  name   = "cheapest-node-server"
  region = "sfo3"  # Change to an available region
  size   = "s-1vcpu-512mb-10gb"  
  image  = "ubuntu-22-04-x64"
  ssh_keys = [var.ssh_key_fingerprint]
}


resource "digitalocean_firewall" "node_firewall" {
  name = "node-firewall"

  droplet_ids = [digitalocean_droplet.node_server.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]  # Restrict this to your IP for security
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "3000"
    source_addresses = ["0.0.0.0/0"]  # Allow web access
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "all"
    destination_addresses = ["0.0.0.0/0"]
  }
}
