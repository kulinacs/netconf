provider "libvirt" {
    uri = "qemu+ssh://root@master.hm.kulinacs.com/system"
}

resource "libvirt_volume" "centos" {
  name   = "centos8.qcow2"
  pool   = "fs"
  source = "https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2"
  format = "qcow2"
}

resource "libvirt_network" "bridge" {
  name = "bridge"
  mode = "bridge"
  bridge = "br0"
  autostart = true

  dns {
    enabled = false
  }
}

module "elastic" {
  source = "./centos"

  base_volume_id = libvirt_volume.centos.id
  name           = "elastic"
  network_name   = libvirt_network.bridge.name
  pool           = "fs"
  username       = "kulinacs"
  ssh_key        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOP78FDtl87/nxkEtcq9vepcyV2w2bcrn59G7BGnr73E kulinacs@bernstein"
  address        = "192.168.2.10/24"
  gateway        = "192.168.2.1"
  memory         = "8192"
  vcpu           = 4
}
