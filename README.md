# Bash scripts

Collection of useful bash scripts

## ansible-vault

### Script ansible-vault-script.sh

This script encrypts plain secrets and decrypts encrypted secrets with ansible vault

#### Requirements:

* "Vault master key" file must be present.
* "Vault user" must be known
* Secrets to decrypt must be added in a file and without "!vault|"

#### Usage: 

* Create a directory
* Inside the directory
  * Download the script into a directory 
  * Create file and add the `Vault master key` into it
  * Run the script `./ansible_vault_script.sh` help to display the usage instructions for encryption or decryption
  * File `key_vault_encrypted` contains the encrypted secret after encryption
  * File `key_vault_decrypted` contains the plain secret after decryption

Structure of `ansible_vault` folder

```
ansible_vault/
  ├── ansible-vault-script.sh
  ├── key_vault_encrypted
  ├── key_vault_decrypted
  └── master-key
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
