#!/bin/bash

echo "Retrieve jq"
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x jq

echo "-- Test API --"
resp=$(curl -ks "https://api.eu-de.apiconnect.ibmcloud.com/fdutorg-dev/sb/version/api" --header 'accept: application/json' --header 'x-ibm-client-id: 2e5af197-f92d-4c25-b490-192449f06483' |  jq .httpCode | sed -e s/\"//g )

echo "-- Show response --"
echo "resp: $resp"

if [ "$resp" == "null" ] 
then
 # Test if resq=null 
 echo "Test OK"
else
 echo "Test KO"
 exit 1
fi