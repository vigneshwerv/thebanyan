resource "hcloud_ssh_key" "vignesh" {
  name       = "vignesh"
  public_key = <<EOT
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKfrJNa6zj4eiTc3BIadsB+kMcUT2pIf+oapRNcx35lp vignesh.vaid@gmail.com
EOT
}

resource "hcloud_firewall" "bastion" {
  name = "bastion"

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol = "tcp"
    port = "5138"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_server" "bastion" {
  // Debian 12 x86
  image    = "114690387"
  name     = "bastion"
  location = var.location

  server_type = "cpx11"

  ssh_keys = [
    hcloud_ssh_key.vignesh.name
  ]

  firewall_ids = [
    hcloud_firewall.bastion.id
  ]

  user_data = file("${path.module}/user_data.yml")
}
