#!/usr/bin/env zsh

# Load environment variables from .env file
env_file_name=bmc_anvil_github.env

if [[ -f $env_file_name ]]; then
    echo "loading github configuration from [$env_file_name]"
    source $env_file_name
else
    echo "Error: [$env_file_name] file not found."
    exit 1
fi

echo "Starting to clone repositories from organization: $ORGANIZATION_OR_USER_NAME"

# Get the list of repositories using the personal access token
echo "Fetching list of repositories..."
repos=$(curl -s "https://api.github.com/orgs/$ORGANIZATION_OR_USER_NAME/repos?per_page=100" | jq -r '.[].name')
if [ -z "$repos" ]; then
    echo "Error: No repositories found or failed to fetch repositories."
    exit 1
fi
echo "Found repositories: ${(F)repos}"

# Loop through each repository
for repo_name in ${(f)repos}; do
    echo "\nProcessing repository: [$repo_name]"

    folder_structure=""


    # Special repositories and general case
    case "$repo_name" in
        "$PAGES_REPO_NAME")
            folder_structure=$ORGANIZATION_OR_USER_NAME/$PAGES_REPO_FOLDER_TARGET
            ;;
        "$GITHUB_REPO_NAME")
            folder_structure=$ORGANIZATION_OR_USER_NAME/$GITHUB_REPO_FOLDER_TARGET
            ;;
        *)
            # Replace dots with slashes for the folder structure
            folder_structure=$ORGANIZATION_OR_USER_NAME/${repo_name//./\/}
            ;;
    esac

    if [ -d $folder_structure ]; then
        echo "repo folder: [$folder_structure] already exists, delete the folder if you want to re-clone it"
        continue
    fi

    echo "Folder structure will be: [$folder_structure]"
    mkdir -p "$folder_structure"

    # Clone the repository into the folder structure
    echo "Cloning repository into [$folder_structure]..."
    git clone "https://github.com/$ORGANIZATION_OR_USER_NAME/$repo_name.git" "$folder_structure"
    echo "Successfully cloned [$repo_name] into [$folder_structure]"
done

echo "\nAll repositories have been cloned successfully."

