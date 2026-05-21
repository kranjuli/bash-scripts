#!/usr/bin/env bash

# Shell script to run an Ansible playbook to set up a Raspberry Pi

set -o pipefail

# Check if .env file exists and load environment variables
if [ -f .env ]; then
    set -a
    source .env
    set +a
else
    echo "❌ .env file not found. Please create one."
    exit 1
fi

run_ansible_playbook() {

    echo "🔍 Checking if required environment variables are set..."
    : "${ANSIBLE_HOSTS:?Missing ANSIBLE_HOSTS variable in .env file. Please run \"$0 show-variables\" to see all required variables.}"
    : "${ANSIBLE_USER:?Missing ANSIBLE_USER variable in .env file. Please run \"$0 show-variables\" to see all required variables.}"
    : "${ANSIBLE_SSH_KEY:?Missing ANSIBLE_SSH_KEY variable in .env file. Please run \"$0 show-variables\" to see all required variables.}"
    : "${ANSIBLE_EXTRA_VARIABLES:?Missing ANSIBLE_EXTRA_VARIABLES variable in .env file. Please run \"$0 show-variables\" to see all required variables.}"

    local playbook_file="$1"
    local description="$2"

    if [ ! -f "$playbook_file" ]; then
        echo "Error: Playbook file '$playbook_file' not found!"
        exit 1
    fi

    echo "🚀 Starting Ansible playbook: $description"

    # build command as array to handle spaces in variables
    local ansible_command=(
        ansible-playbook
        -i "$ANSIBLE_HOSTS",
        "$playbook_file"
        -u "$ANSIBLE_USER"
        --private-key "$ANSIBLE_SSH_KEY"
    )

    # Add extra variables if set
    if [ -n "${ANSIBLE_EXTRA_VARIABLES:-}" ]; then
        ansible_command+=(-e "$ANSIBLE_EXTRA_VARIABLES")
    fi

    "${ansible_command[@]}"
}

show_environment_variables() {
    echo "Listing current environment variables..."
    found=false
    while IFS='=' read -r key value; do
        # ignore comments and empty lines
        [[ "$key" =~ ^#.*$ || -z "$key" ]] && continue
        found=true
        printf '%s=[%q]\n' "$key" "$value"
    done < .env

    if [[ "$found" == false ]]; then
        echo "No variables found in .env."
    fi
}

case "$1" in
    show-variables)
        show_environment_variables
        ;;

    basic-setup)
        run_ansible_playbook \
            "playbooks/basic_setup_pi.yml" \
            "Raspberry Pi basic setup"
        ;;

    install-docker)
        run_ansible_playbook \
            "playbooks/install_docker_pi.yml" \
            "Install Docker on Raspberry Pi"
        ;;

    clone-github-repos)
        echo "ℹ️ ⚠️ Before running this playbook, ensure that you have cloned a repository from GitHub with SSH manually."
        run_ansible_playbook \
            "playbooks/clone_github_repos_pi.yml" \
            "Clone GitHub repositories on Raspberry Pi"
        ;;

    mount-ssd)
        run_ansible_playbook \
            "playbooks/mount_ssd_pi.yml" \
            "Mount SSD on Raspberry Pi"
        ;;

    build-docker-images)
        run_ansible_playbook \
            "playbooks/build_docker_images_pi.yml" \
            "Build Docker images on Raspberry Pi"
        ;;
    *)
        echo "ℹ️  Usage: $0 check-variables|basic-setup|install-docker|clone-github-repos|mount-ssd|build-docker-images"
        exit 1
        ;;
esac
# End of script
