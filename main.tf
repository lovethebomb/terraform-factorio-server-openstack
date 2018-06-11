terraform {
  backend "swift" {
    container = "factorio-lucas-state"
  }
}

# configure your openstack provider to target the region of your choice
provider "openstack" {
  region = "${var.region}"
}

resource "openstack_compute_keypair_v2" "keypair" {
  name       = "${var.name}"
  public_key = "${file(var.ssh_key)}"
}

# Create your Virtual Machine
resource "openstack_compute_instance_v2" "instance" {
  # name the instances according to the count number
  name = "${var.name}"

  # Choose your base image from our catalog
  image_name = "${var.image}"

  # Choose a flavor type
  flavor_name = "${var.flavor}"

  # Target your brand new keypair
  key_pair = "${openstack_compute_keypair_v2.keypair.name}"

  # Attach your VM to the according ports
  network {
    port           = "${openstack_networking_port_v2.public_port.id}"
    access_network = true
  }
}

resource "null_resource" "setup" {
  connection {
    host        = "${openstack_compute_instance_v2.instance.access_ip_v4}"
    user        = "debian"
    private_key = "${file(var.ssh_key)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt -y update && sudo apt -y upgrade",
      "(sleep 1 && sudo reboot -h now)&",
    ]
  }
}

resource "null_resource" "provision" {
  connection {
    host        = "${openstack_compute_instance_v2.instance.access_ip_v4}"
    user        = "debian"
    private_key = "${file(var.ssh_key)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt -y install curl", # for salt
    ]
  }

  provisioner "salt-masterless" {
    "local_state_tree"    = "${var.salt_local_state_tree}"
    "remote_state_tree"   = "${var.salt_remote_state_tree}"
    "local_pillar_roots"  = "${var.salt_local_pillar_roots}"
    "remote_pillar_roots" = "${var.salt_remote_pillar_roots}"
  }
}
