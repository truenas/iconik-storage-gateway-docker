#!/bin/bash
set -e

REPO_BASE=https://packages.iconik.io/deb/ubuntu

apt-get update && apt-get install -y wget gnupg
wget -O - ${REPO_BASE}/dists/jammy/iconik_package_repos_pub.asc | apt-key add -
echo "deb [trusted=yes] ${REPO_BASE} ./jammy main" >/etc/apt/sources.list.d/iconik.list
apt-get update
apt-get install -y iconik-storage-gateway
