#!/usr/bin/bash

# curl command to query openAI API

url="https://api.openai.com/v1/responses";
my_model="gpt-3.5-turbo";
key_file="/home/tolonen/.openAI/key_openAI.txt";
my_key=$(cat "$key_file")
output_file="/home/tolonen/Downloads/ai_haiku_response.json"
my_message="When was your last update?";

curl "$url" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $my_key" \
  -d "{
    \"model\": \"$my_model\",
    \"input\": \"$my_message\",
    \"store\": true
  }" \
> $output_file

cat $output_file | jq '.output[0].content[0].text' 
