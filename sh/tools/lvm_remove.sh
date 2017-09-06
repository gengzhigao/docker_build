#!/bin/bash

function lvm_remove_v1()
{
	umount /data
	systemctl stop docker
	rm -rf /var/lib/docker
	lvremove dockerdata
	lvremove metadata
	lvremove data
	vgremove vg-docker
	pvremove /dev/sdb
}

function lvm_remove()
{
	umount /data
	systemctl stop docker
	rm -rf /var/lib/docker
	lvremove data
	lvremove thinpool
	lvremove thinpoolmeta
	vgremove docker
	pvremove /dev/sdb
}

lvm_remove