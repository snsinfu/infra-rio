resource "cloudflare_record" "rio" {
  domain  = var.domain_zone
  name    = "rio"
  type    = "A"
  value   = "${hcloud_server.master.ipv4_address}"
  proxied = true
}

resource "cloudflare_record" "rio-bastion" {
  domain  = var.domain_zone
  name    = "rio-bastion"
  type    = "A"
  value   = "${hcloud_server.master.ipv4_address}"
  proxied = false
}
