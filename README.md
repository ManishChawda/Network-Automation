# Network Automation Using Ansible

## Overview
This project automates configuration backups for HP Aruba switches using Ansible. The playbooks run on an Ubuntu Ansible Master and save switch configuration backups to a Windows TFTP server.

## Environment
- **Control Node:** Ubuntu Ansible Master
- **Automation Tool:** Ansible
- **Network Devices:** HP Aruba 2530 switches
- **Connection:** SSH on port 2222
- **Network OS:** ArubaOS / AOS Switch
- **Backup Destination:** Windows TFTP server

## Project Structure
```text
Network-Automation/
├── inventory/
│   ├── mcp-grkl-sw-2530.yml
│   └── vault.yml
├── playbooks/
│   └── mcp-grkl-sw-2530.yml
├── backups/
│   ├── MCP-SW-2530-running-config.txt
│   └── GRKL-SW-2530-running-config.txt
├── roles/
├── script/
└── .gitignore
```

## Features
- Automated switch configuration backups.
- Supports MCP and GRKL locations.
- Uses Ansible Vault to protect switch credentials.
- Transfers configuration backups to a TFTP server.
- Supports running backups for individual switches.

## Configuration
1. Update switch management IP addresses in the inventory file.
2. Configure the TFTP server IP addresses.
3. Store credentials securely in `inventory/vault.yml`.
4. Encrypt the Vault file using Ansible Vault.
5. Verify SSH connectivity from the Ubuntu Ansible Master.

## Run the Backup

Run the following commands from the project directory:

```bash
ansible-inventory -i inventory/mcp-grkl-sw-2530.yml --list
```

Back up the MCP switch:

```bash
ansible-playbook -i inventory/mcp-grkl-sw-2530.yml playbooks/mcp-grkl-sw-2530.yml --ask-vault-pass --limit=MCP-SW-2530
```

Back up the GRKL switch:

```bash
ansible-playbook -i inventory/mcp-grkl-sw-2530.yml playbooks/mcp-grkl-sw-2530.yml --ask-vault-pass --limit=GRKL-SW-2530
```

Back up both switches:

```bash
ansible-playbook -i inventory/mcp-grkl-sw-2530.yml playbooks/mcp-grkl-sw-2530.yml --ask-vault-pass
```

## Windows Backup Launcher

The project includes a Windows batch file (`Backup-Config.bat`) that allows administrators to trigger an Ansible switch configuration backup directly from Windows using PuTTY's `plink.exe`.

### Prerequisites
- Ubuntu Ansible Master must be reachable over SSH.
- PuTTY `plink.exe` must be installed and available in the Windows PATH.
- Ansible and the required project files must be configured on Ubuntu.
- Ansible Vault credentials must be available when prompted.

### Usage
1. Configure the Ubuntu username and server IP in your local batch file.
2. Run `Backup-Config.bat` from Windows.
3. Enter the Ansible Vault password when prompted.
4. Review the output to confirm the backup completed successfully.

**Security:** Do not commit real usernames, internal IP addresses, passwords, or other sensitive infrastructure details in the batch file. Use sanitized placeholders in the public repository.

## Security
- Never commit passwords or unencrypted Vault files to GitHub.
- Keep `inventory/vault.yml` excluded using `.gitignore`.
- Do not publish sensitive network configuration files or internal infrastructure details.
- Use SSH instead of Telnet for management.
- Review configuration backups before publishing the repository.

## Disclaimer
This project is intended for authorized network administration and lab use. Test changes in a non-production environment before applying them to production devices.
