#!/bin/bash
# update_dns.sh - Update Cloudflare DNS record if the public IP has changed

# Use environment variables, with a fallback if needed.
CF_API_TOKEN="${CF_API_TOKEN:-}"
ZONE_ID="${ZONE_ID:-}"
RECORD_ID="${RECORD_ID:-}"
RECORD_NAME="${RECORD_NAME:-demo.mrmikenguyen.com}"  # Default to demo.mrmikenguyen.com or change as needed
TTL="${TTL:-300}"
PROXIED="${PROXIED:-false}"

# Retrieve the current public IP of the EC2 instance.
CURRENT_IP=$(curl -s http://checkip.amazonaws.com | tr -d '\n')

# Retrieve the current DNS record IP from Cloudflare.
DNS_IP=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${RECORD_ID}" \
  -H "Authorization: Bearer ${CF_API_TOKEN}" \
  -H "Content-Type: application/json" | jq -r '.result.content')

echo "Current Public IP: $CURRENT_IP"
echo "DNS Record IP: $DNS_IP"

# Compare IPs and update if necessary.
if [ "$CURRENT_IP" != "$DNS_IP" ]; then
  echo "IP has changed from ${DNS_IP} to ${CURRENT_IP}. Updating DNS record..."
  UPDATE_RESPONSE=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${RECORD_ID}" \
    -H "Authorization: Bearer ${CF_API_TOKEN}" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"A\",\"name\":\"${RECORD_NAME}\",\"content\":\"${CURRENT_IP}\",\"ttl\":${TTL},\"proxied\":${PROXIED}}")
  echo "Update response: ${UPDATE_RESPONSE}"
else
  echo "No change in IP detected. DNS record is up to date."
fi