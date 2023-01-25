resource "hcloud_ssh_key" "vignesh" {
  name = "vignesh"
  public_key = <<EOT
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKfrJNa6zj4eiTc3BIadsB+kMcUT2pIf+oapRNcx35lp vignesh.vaid@gmail.com
EOT
}

resource "hcloud_firewall" "postgres-server" {
  name = "postgres-server"

  rule {
    direction = "in"
    protocol = "tcp"
    port = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol = "tcp"
    port = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol = "tcp"
    port = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_server" "postgres-server" {
  image       = "debian-11"
  name        = "postgres-server"
  location    = var.location

  server_type = "cpx11"

  ssh_keys = [
    hcloud_ssh_key.vignesh.name
  ]

  firewall_ids = [
    hcloud_firewall.postgres-server.id
  ]
}

// Use hcloud_server_network for mastodon-server to postgres-server connection
