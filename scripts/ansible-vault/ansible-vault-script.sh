#!/bin/bash

usage() {
    echo "usage:"
    echo "  $0 encrypt <vault_id_user> <vault_master_key> 'string_to_encrypt'"
    echo "  $0 decrypt <vault_id_user> <vault_master_key> <path_to_vault_enrypted_file_without_!vault|>"
    echo
    echo "Examples:"
    echo "  $0 encrypt <vault_id_user> <vault_master_key> 'string_to_encrypt'"
    echo "  $0 decrypt <vault_id_user> <vault_master_key> <path_to_vault_enrypted_file_without_!vault|>"
}

if [ $# -lt 1 ]; then
    echo "ERROR: No action provided."
    usage
fi

case "$1" in
    help)
        usage
        ;;
    encrypt)
        if [ $# -ne 4 ]; then
            echo "ERROR: Invalid number of parameters for 'encrypt'."
            usage
        fi

        vault_id_user="$2"
        vault_master_key="$3"
        string_to_encrypt="$4"
        output_file="key-vault-encrypted"

        ansible-vault encrypt_string --output "$output_file" --vault-id "${vauilt_id_user}@${vault_master_key}" "$string_to_encrypt"

        echo "Encrypted string saved to file: $output_file"
        ;;
    decrypt)
        if [ $# -ne 4 ]; then
            echo "ERROR: Invalid number of parameters for 'decrypt'."
            usage
        fi

        vault_id_user="$2"
        vault_master_key="$3"
        encrypted_file="$4"
        output_file="key-vault-decrypted"

        if [ ! -f "encrypted_file" ]; then
            echo "ERROR: Encrypted file '$encrpyted_file' does not exist."
            exit 1
        fi

        ansible-vault decrypt --output "$output_file" --vault-id "${vauilt_id_user}@${vault_master_key}" "$encrypted_file"

        echo "Encrypted string saved to file: $output_file"       
        ;;
    *)
        echo "ERROR: Invalid action '$1'."
        usage
        ;;
