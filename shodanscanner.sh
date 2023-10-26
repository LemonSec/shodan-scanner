#!/bin/bash

# Check if the IPs.txt file exists
if [ ! -f "IPs.txt" ]; then
    echo "IPs.txt file not found."
    exit 1
fi

# Create or clear the results.txt file
> results.txt

# Loop through each line in the file
while IFS= read -r ip; do
    # Run the ipinfo command with the current IP address and redirect output to results.txt
    result=$(shodan host "$ip" 2>&1)
    
    # Check if the result contains the "Error" message and skip it
    if [[ $result != *"Error: No information available for that IP."* ]]; then
        echo "$result" >> results.txt
    fi
done < "IPs.txt"
