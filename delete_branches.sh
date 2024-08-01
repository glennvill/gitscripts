#!/opt/homebrew/bin/bash

# Declare an associative array only works in Bash v4
declare -A systems

echo "Bash version: $BASH_VERSION"

# Populate the associative array with key-value pairs
systems=(
  [sample_system]=952
  [another_system]=953
)

# New branch name
branch_name="common_develop_08_01"


# Array to store repository names
repo_names=()

# Loop through each repository
for repo_name in "${!systems[@]}"
do

  
    # Unprotect the branch
    echo "Processing repository: $repo_name with ID: ${systems[$repo_name]}"
    response=$(curl -s -X PUT -H "Content-Type: application/x-www-form-urlencoded" \
                   -H "PRIVATE-TOKEN: " \
                   http://git..com/api/v3/projects/${systems[$repo_name]}/repository/branches/$branch_name/unprotect)

    echo "Unprotect Response: $response"

    # Delete the branch
    response=$(curl -s -X DELETE -H "Content-Type: application/x-www-form-urlencoded"\
                   -H "PRIVATE-TOKEN: " \
                   http://git..com/api/v3/projects/${systems[$repo_name]}/repository/branches/$branch_name)
    

    echo "Delete: $response"
    echo "Branch $branch_name deleted in $repo_name"

    # Store repository name in the array
    repo_names+=("$repo_name")
done

echo "All branches in repositories deleted. branch name: $branch_name"
echo "Repository names: ${repo_names[@]}"

