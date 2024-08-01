#!/opt/homebrew/bin/bash

# Declare an associative array only works in bash v4
declare -A systems

echo "Bash version: $BASH_VERSION"

# Populate the associative array with key-value pairs
systems=(
  [sample_system]=952
  [another_system]=953
)


# New branch name
new_branch="common_develop_08_01"


# Array to store repository names
repo_names=()

# Loop through each repository
for repo_name in "${!systems[@]}"
do
    echo "Processing repository: $repo_name with ID: ${systems[$repo_name]}"
    response=$(curl -H "Content-Type: application/x-www-form-urlencoded" \
                   -H "PRIVATE-TOKEN: " \
                   --data "branch_name=$new_branch&id=631&ref=master" \
                   http://git..com/api/v3/projects/${systems[$repo_name]}/repository/branches)
    
    echo "Response: $response"
    echo "Branch $new_branch created and pushed to $repo_name"

    #Protect the new branch
    protect_response=$(curl -s -X PUT -H "Content-Type: application/json" \
                       -H "PRIVATE-TOKEN: " \
                       --data '{"name":"'"$new_branch"'","push_access_level":"maintainer","merge_access_level":"maintainer"}' \
                       "http://git..com/api/v3/projects/${systems[$repo_name]}/repository/branches/$new_branch/protect")
    
    

    echo "Protect Response: $protect_response"
    echo "Branch $new_branch protected in $repo_name"
    echo ""

    # Store repository name in the array
    repo_names+=("$repo_name")
done

echo "All repositories updated with new branch: $new_branch"
echo "Repository names: ${repo_names[@]}"

