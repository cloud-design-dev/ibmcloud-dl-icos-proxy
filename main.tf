resource "ibm_compute_vm_instance" "icos_proxy_node" {
  hostname             = var.hostname
  domain               = var.domain
  os_reference_code    = var.os_image
  datacenter           = var.datacenter
  network_speed        = 1000
  hourly_billing       = true
  private_network_only = false
  local_disk           = true
  user_metadata        = templatefile("${path.module}/installer.sh", { fqdn = "${var.hostname}.${var.domain}", private_icos_endpoint = var.private_icos_endpoint })
  flavor_key_name      = var.flavor
  tags                 = [var.datacenter]
  ssh_key_ids          = [data.ibm_compute_ssh_key.deploymentKey.id]
}


resource "dnsimple_record" "icos_proxy_node_dns" {
  depends_on = [ibm_compute_vm_instance.icos_proxy_node]
  domain = var.domain
  name   = var.hostname
  value  = ibm_compute_vm_instance.icos_proxy_node.ipv4_address
  type   = "A"
  ttl    = 3600
}

output "instance_ip" {
  value = ibm_compute_vm_instance.icos_proxy_node.ipv4_address
}