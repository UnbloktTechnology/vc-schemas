#!/bin/bash

# Upload to issuer
#
#for file in $(find ipfs/ -type f -name "*.json"); do
#  echo "JSON file: $file"
#  version=$(cat "$file" | jq -r '.["$metadata"].version')
#  echo "$version"
#
#  schema=$(cat "$file" | jq -r '.["$metadata"].type')
#  echo "$schema"
#
#  response=$(curl "https://ipfs.infura.io:5001/api/v0/add" -X POST -F file=@"$file" -u "xxx:xxx")
#  echo "$response"
#
#  # Parse HASH from uploaded file
#  ipfs_hash=$(echo "$response" | jq -r '.Hash')
#  echo "$ipfs_hash"
#
##  curl -X POST "https://amoy-issuer-node-dev.nexera.id/v1/schemas" \
##    -H "accept: application/json" \
##    -H "content-type: application/json" \
##    -u "xxx:xxx" \
##    -d "{\"url\":\"https://quicknode.quicknode-ipfs.com/ipfs/${ipfs_hash}\",\"schemaType\":\"${schema}\",\"version\":\"${version}\"}"
#done

# Upload to issuer (quicknode)
for file in $(find ipfs/ -type f -name "*.json"); do
  echo "JSON file: $file"
  version=$(cat "$file" | jq -r '.["$metadata"].version')
  echo "$version"

  schema=$(cat "$file" | jq -r '.["$metadata"].type')
  echo "$schema"

  response=$(curl --location "https://api.quicknode.com/ipfs/rest/v1/s3/put-object" -X POST -F Body=@"$file" -F Key="$file" -F ContentType="application/json" -H "x-api-key: xxx")
  echo "$response"

  # Parse HASH from uploaded file
  ipfs_hash=$(echo "$response" | jq -r '.pin.cid')
  echo "$ipfs_hash"

  curl -X POST "https://amoy-issuer-node-prod.nexera.id/v1/schemas" \
    -H "accept: application/json" \
    -H "content-type: application/json" \
    -u "xxx:xxxx" \
    -d "{\"url\":\"https://quicknode.quicknode-ipfs.com/ipfs/${ipfs_hash}\",\"schemaType\":\"${schema}\",\"version\":\"${version}\"}"
done

# Upload to IPFS

#for file in $(find ipfs/ -type f -name "*.jsonld"); do
#  echo "JsonLD file: $file"
#
#  # Upload json
#  response=$(curl --location "https://api.quicknode.com/ipfs/rest/v1/s3/put-object" -X POST -F Body=@"$file" -F Key="$file" -F ContentType="application/json" -H "x-api-key: xxx")
#  echo "$response"
#
#  # Parse HASH from uploaded file
#  ipfs_hash=$(echo "$response" | jq -r '.pin.cid')
#  echo "$ipfs_hash"
#
#  # Set the json file path
#  replacement=".json"
#  json_file_path="${file/.jsonld/$replacement}"
#  echo "JSON file: $json_file_path"
#
#  # Perform update
#  jq '.["$metadata"].uris.jsonLdContext = "https://quicknode.quicknode-ipfs.com/ipfs/'"$ipfs_hash"'"' "$json_file_path" > temp.json && mv temp.json "$json_file_path"
#done
#
#commit_message="$(git log --pretty=%B -1  | cat - | head -n1 | tr -d '"')"