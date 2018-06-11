# terraform-factorio-server-openstack

This is an opiniated and incomplete project, mainly created to play with [Terraform](https://www.terraform.io) and [SaltStack](https://saltstack.com/) in masterless mode.

The provider used is [OpenStack](https://www.openstack.org/), mainly based on [OVH](https://www.ovh.com)'s OpenStack offer.
This repository is based on the work of [@yanndegat](https://github.com/yanndegat), in [terraform-ovh-common](shttps://github.com/ovh/terraform-ovh-commons).

## Requirements

* openrc.sh

You'll need an `openrc.sh` file, filled manually or [provided directly from Horizon](https://docs.openstack.org/zh_CN/user-guide/common/cli-set-environment-variables-using-openstack-rc.html), the OpenStack dashboard.

A sample file is provided as reference.

* Terraform [Installation instructions](https://www.terraform.io/intro/getting-started/install.html)
* Edited Terraform variables

Feel free to edit the provided variables in `variables.tf` or overwrite them.

* Edited Pillar variables

```bash
cp pillar/factorio-example.sls pillar/factorio.sls
```

Edit the variables in the pillar to secure your server.

## Usage

```bash
terraform apply
```

## Factorio

The server expects a savegame by default, at location `/opt/factorio/saves/latest.zip`

The factorio server can be controlled by a systemd unit, described in `salt/systemd/factorio.service`:

```bash
service factorio start/stop
```