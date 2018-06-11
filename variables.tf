# OpenStack
variable "region" {
  description = "The id of the openstack region"
  default     = "GRA1"
}

variable "flavor" {
  description = "The instance's flavor"
  default     = "vps-ssd-1"
}

variable "image" {
  description = "The instance's image"
  default     = "Debian 9"
}

variable "name" {
  description = "The name of the swift container for the terraform backend remote state"
  default     = "factorio-lucas"
}

variable "ssh_key" {
  description = "The ssh key path used to connect to the instance"
  default     = "keys/id_openstack.pub"
}

# Salt
variable "salt_local_state_tree" {
  description = "local system local_state_tree path"
  default     = "salt"
}

variable "salt_remote_state_tree" {
  description = "Remote system remote_state_tree path"
  default     = "/srv/provision/salt"
}

variable "salt_local_pillar_roots" {
  description = "local system local_pillar_roots path"
  default     = "pillar"
}

variable "salt_remote_pillar_roots" {
  description = "remote system local_pillar_roots path"
  default     = "/srv/provision/pillar"
}

# Factorio
variable "factorio_port" {
  description = "Factorio UDP game server port"
  default     = 34197
}

variable "factorio_rcon_port" {
  description = "Factorio TCP rcon port"
  default     = 27015
}
