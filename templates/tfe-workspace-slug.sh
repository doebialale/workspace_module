which jq &> /dev/null || (curl --silent -Lo ./jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && chmod +x jq)

jq -c -n "{\"workspace_slug\": \"$(echo $TFC_WORKSPACE_SLUG)\"}"