@echo off
title Ansible Switch Configuration Backup

set "UBUNTU_USER=your_linux_username"
set "UBUNTU_HOST=your_ubuntu_server_ip"
set "PROJECT_DIR=~/Projects/Network-Automation"

plink.exe -ssh -t %UBUNTU_USER%@%UBUNTU_HOST% "cd %PROJECT_DIR% && ansible-playbook -i inventory/mcp-grkl-sw-2530.yml playbooks/mcp-grkl-sw-2530.yml --ask-vault-pass --limit=MCP-SW-2530"

pause
