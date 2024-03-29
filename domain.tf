resource "cloudflare_record" "rio" {
  domain  = var.domain_zone
  name    = "rio"
  type    = "A"
  value   = "${hcloud_server.master.ipv4_address}"
  proxied = false
}
