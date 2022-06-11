which jq &> /dev/null || (curl --silent -Lo ./jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && chmod +x jq)

id=$(curl -s \
      --header "Authorization: Bearer $TFE_TOKEN" \
      --header "Content-Type: application/vnd.api+json" \
      "https://$TFE_HOSTNAME/api/v2/organizations/${organization}/oauth-clients" \
      | jq -sr '.[].data[] | select(.attributes.name=="${connection}") | .relationships["oauth-tokens"].data[].id')
jq -c -n --arg id "$id" '{"id": $id}'