# create the security group to which the instances & ports will be associated
resource "openstack_networking_secgroup_v2" "sg" {
  name        = "${var.name}_default_sg"
  description = "${var.name} security group"
}

# allow remote ssh connection only for terraform host
resource "openstack_networking_secgroup_rule_v2" "in_traffic_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "${trimspace(data.http.myip.body)}/32"
  port_range_min    = 22
  port_range_max    = 22
  security_group_id = "${openstack_networking_secgroup_v2.sg.id}"
}

# allow Factorio traffic ipv4
resource "openstack_networking_secgroup_rule_v2" "in_traffic_factorio_ipv4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_ip_prefix  = "0.0.0.0/0"
  port_range_min    = "${var.factorio_port}"
  port_range_max    = "${var.factorio_port}"
  security_group_id = "${openstack_networking_secgroup_v2.sg.id}"
}

# allow Factorio traffic ipv6
resource "openstack_networking_secgroup_rule_v2" "in_traffic_factorio_ipv6" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "udp"
  remote_ip_prefix  = "::/0"
  port_range_min    = "${var.factorio_port}"
  port_range_max    = "${var.factorio_port}"
  security_group_id = "${openstack_networking_secgroup_v2.sg.id}"
}

# allow Factorio RCON traffic ipv4
resource "openstack_networking_secgroup_rule_v2" "in_traffic_factorio_rcon_ipv4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  port_range_min    = "${var.factorio_rcon_port}"
  port_range_max    = "${var.factorio_rcon_port}"
  security_group_id = "${openstack_networking_secgroup_v2.sg.id}"
}

# allow Factorio RCON traffic ipv6
resource "openstack_networking_secgroup_rule_v2" "in_traffic_factorio_rcon_ipv6" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  remote_ip_prefix  = "::/0"
  port_range_min    = "${var.factorio_rcon_port}"
  port_range_max    = "${var.factorio_rcon_port}"
  security_group_id = "${openstack_networking_secgroup_v2.sg.id}"
}

# allow ingress traffic inter instances
resource "openstack_networking_secgroup_rule_v2" "ingress_instances" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_group_id   = "${openstack_networking_secgroup_v2.sg.id}"
  security_group_id = "${openstack_networking_secgroup_v2.sg.id}"
}

# allow egress traffic worldwide
resource "openstack_networking_secgroup_rule_v2" "egress_instances" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.sg.id}"
}

# use a data source to retrieve Ext-Net network id for your target region
data "openstack_networking_network_v2" "ext_net" {
  name      = "Ext-Net"
  tenant_id = ""
}

# create a port before the instances allows you
# to keep your IP when you taint an instance
resource "openstack_networking_port_v2" "public_port" {
  name           = "${var.name}"
  network_id     = "${data.openstack_networking_network_v2.ext_net.id}"
  admin_state_up = "true"

  # the security groups are attached to the ports, not the instance.
  security_group_ids = ["${openstack_networking_secgroup_v2.sg.id}"]
}
