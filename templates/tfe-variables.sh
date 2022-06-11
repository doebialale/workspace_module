which jq &> /dev/null || (curl --silent -Lo ./jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && chmod +x jq)

GOT_RESULT=1
TRY_COUNT=0
MAX_TRY_COUNT=$${MAX_TRY_COUNT:=10}
URL="https://$TFE_HOSTNAME/api/v2/workspaces/${workspace_id}/vars"

until [[ $GOT_RESULT -eq 0  || $TRY_COUNT -ge $MAX_TRY_COUNT ]];do
  >&2 echo "Getting workspace variables from $URL"
  api_result=$(curl -s \
              --header "Authorization: Bearer $TFE_TOKEN" \
              --header "Content-Type: application/vnd.api+json" \
              "$URL" \
              | jq -sr '.[].data | .[] | .attributes | del(."created-at") | @base64' 2>/dev/null) 
  # TFE_HOSTNAME is always set on a workspace-manager; if we don't see it, we need to try again
  (base64 -d <<< "$api_result" | grep -q TFE_HOSTNAME) && GOT_RESULT=0
  sleep $TRY_COUNT
  ((TRY_COUNT++))
done

if [[ $GOT_RESULT -eq 1 ]];then
  echo "❌ FAILED TO RETRIEVE WORKSPACE VARIABLES AFTER $TRY_COUNT ATTEMPTS. TRY TO RE-APPLY WORKSPACE-MANAGER."
  exit 1
fi

base64=$(for v in $api_result;do
  json=$(echo $v | base64 --decode | jq '.')
  key=$(echo $json | jq -r '.key')
  if ! grep -q -E "TFE_HOSTNAME|TFE_TOKEN|TF_LOG|MAX_TRY_COUNT|environment" <<< $key;then # We don't want to propagate these variables. "environment" is set within the workspace
    value=$(env | grep "^$key=" | awk -F= '{print $2}')
    echo $json | jq -c -r ". | .value |= \"$value\""
  fi
done | sed -e '1s/^/[/;$!s/$/,/;$s/$/]/' | base64 --wrap=0)

jq -c -n --arg base64 "$base64" --arg try_count "$TRY_COUNT" '{"base64": $base64, "try_count": $try_count}'