resource "hcloud_server" "postgres" {
  name = "postgres"
  image = "debian-11"
  server_type = "cpx21"
  location = "hil"
}
