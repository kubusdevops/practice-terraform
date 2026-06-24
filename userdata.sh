#!/bin/bash

# get admin privileges
sudo su

# install httpd
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
echo "God pls want to be a devops engineer by all means" > /var/www/html/index.html




# Exit immediately if a command exits with a non-zero status
set -e

# --- CONFIGURATION ---
# Replace these values with your desired username and public SSH key
USERNAME="kubus"
SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDn6Hr+FfIN5pLOLt5P0+Z16bqrwA6g1QN22CZGrG3XQOWL/TvqpU87gJ42g5mjR4exvFNtYnfBbMlFRY06pbSnjx72iG1K45b4aZhElKvDoVCYEmQOtTXYbUotwEwyw2Op/rpD7P796pogSe2gTYwv37YbvwydNeNBLBFrC4ZbrBMWLagxR/fnXSobZDUva2gKj8ahP/1Zm/1Na8u1+kak4gQQKsRkEpkfxWmUxxYGUFoZFYvKH+hEq7V6abDVvqGwios97eyAabwd2W2CxT42VybssQ330bvrxivjQBNDPooDM4u6lRj33NLOuaExSNX16ZRegjypwEF/4o042ctnDb8J+u1BMX7facBweg0r85StlnNdP9ZWiWCfWrDmfcd+/H4zNI1Sekd5uJQ57YmZKuaf9Lu57Z+BEsi8JIxkvBtbB6apFRdh2mc0MRdEMBX6+qJLWYHD5TgQtUYEhA+3BJnHcFRt0MXnaxSURCQDViJ9ZUQGjcQRw6gL6TZ12vM= kubus@GeorgeAkwari"
# ---------------------

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (using sudo)."
  exit 1
fi

echo "Creating new Linux user: ${USERNAME}..."

# 1. Create the user account with a home directory and bash shell
if id "${USERNAME}" &>/dev/null; then
    echo "User ${USERNAME} already exists. Skipping user creation."
else
    useradd -m -s /bin/bash "${USERNAME}"
    echo "User ${USERNAME} created successfully."
fi

# 2. Set up the .ssh directory
USER_HOME="/home/${USERNAME}"
SSH_DIR="${USER_HOME}/.ssh"

echo "Setting up SSH directory..."
mkdir -p "${SSH_DIR}"

# 3. Add the public key to authorized_keys
# Using a temporary block to avoid overwriting existing keys if the user existed
AUTHORIZED_KEYS="${SSH_DIR}/authorized_keys"

if [ -f "${AUTHORIZED_KEYS}" ] && grep -qF "${SSH_PUBLIC_KEY}" "${AUTHORIZED_KEYS}"; then
    echo "SSH Public Key is already present in authorized_keys."
else
    echo "${SSH_PUBLIC_KEY}" >> "${AUTHORIZED_KEYS}"
    echo "SSH Public Key added successfully."
fi

# 4. Set strict file and folder permissions required by SSH
echo "Setting secure permissions..."
chmod 700 "${SSH_DIR}"
chmod 600 "${AUTHORIZED_KEYS}"
chown -R "${USERNAME}":"${USERNAME}" "${SSH_DIR}"

# 5. Optional: Grant sudo permissions to the new user
# Uncomment the 2 lines below if the user needs root/admin privileges
# echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${USERNAME}"
# chmod 0440 "/etc/sudoers.d/${USERNAME}"

echo "All steps completed! The user '${USERNAME}' can now log in using their private SSH key."
