# Bash scripts

Collection of useful bash scripts

## ansible-vault

### Script ansible-vault-docker.sh

This script encrypts plain secrets and decrypts encrypted secrets with ansible vault by using docker image `ansible`.

#### Requirements:

* Docker muss be installed. Ansible Image will be downloaded and the Docker container will be created by running the script.
* "Vault master key" files must be present.
* "Vault User" must be known
* Secrets to decrypt must be added in a file (i.e. `key_vault_encrypted_file`) and `without` "!vault|"

#### Usage: 

* Create a directory `ansible_vault`
* Inside the directory
  * Download the script 
  * Create folder `master_keys` and add `Vault master keys` into it
  * Run the script `./ansible_vault_docker.sh help` to display the usage instructions for encryption or decryption
  * **Encryption**: `./ansible_vault_docker.sh encrypt <vault_user> master_keys/<master_key_x> <string_to_encrypt>`. File `key_vault_encrypted` contains the encrypted secret after encryption.
  * **Decryption**: `./ansible_vault_docker.sh decrypt <vault_user> master_keys/<master_key_x> key_vault_encrypted_file`. File `key_vault_decrypted` contains the plain secret after decryption.

Structure of `ansible_vault` folder

```
ansible_vault/
  ├── ansible-vault-script.sh
  ├── key_vault_encrypted
  ├── key_vault_decrypted
  └── master_keys/
      ├── master_key_1
      ├── master_key_2
      └── master_key_3
```

### Script ansible-vault-script.sh

This script encrypts plain secrets and decrypts encrypted secrets with ansible vault.

#### Requirements:

* Ansible must be installed.
* "Vault master key" files must be present.
* "Vault user" must be known
* Secrets to decrypt must be added in a file (i.e. `key_vault_encrypted_file`) and `without` "!vault|"

#### Usage: 

* Create a directory `ansible_vault`
* Inside the directory
  * Download the script
  * Create folder `master_keys` and add `Vault master keys` into it.
  * Run the script `./ansible_vault_script.sh help` to display the usage instructions for encryption or decryption
  * **Encryption**: `./ansible_vault_script.sh encrypt <vault_user> master_keys/<master_key> <string_to_encrypt>`. File `key_vault_encrypted` contains the encrypted secret after encryption.
  * **Decryption**: `./ansible_vault_script.sh decrypt <vault_user> master_keys/<master_key> key_vault_encrypted_file`. File `key_vault_decrypted` contains the plain secret after decryption.

Structure of `ansible_vault` folder

```
ansible_vault/
  ├── ansible-vault-script.sh
  ├── key_vault_encrypted
  ├── key_vault_decrypted
  └── master_keys/
      ├── master_key_1
      ├── master_key_2
      └── master_key_3
```

## Git

### Script remove-all-local-feature-branches.sh

This script cleans uncommitted changes, checks out the main branch, and deletes all local `feature/*` branches older than 14 days in each Git repository under a given base directory.

#### Usage:

Structure of `projects` folder

```
projects/
  ├── project_1/
  ├── project_2/
  ├── project_3/
  ├── project_4/
  ├── project_5/
  └── remove-old-local-feature-branches.sh
```

Add the script into a directory and execute

```bash
./projects/remove-old-local-feature-branches.sh
```

### Script update-local-main-branch.sh

This script updates local main branch in each Git repository under a given base directory.


#### Usage

Structure of `projects` folder

```
projects/
  ├── project_1/
  ├── project_2/
  ├── project_3/
  ├── project_4/
  ├── project_5/
  └── update-local-main-branch.sh
```

Add the script into a directory and execute

```bash
./projects/update-local-main-branch.sh
```
