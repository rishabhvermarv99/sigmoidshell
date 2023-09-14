#!/bin/bash

# Validate the input
function validate_input() {
    local component_name=$1
    local scale=$2
    local view=$3
    local count=$4

    if [[ $component_name != "INGESTOR" && $component_name != "JOINER" && $component_name != "WRANGLER" && $component_name != "VALIDATOR" ]]; then
        echo "Invalid component name"
        return 1
    fi

    if [[ $scale != "MID" && $scale != "HIGH" && $scale != "LOW" ]]; then
        echo "Invalid scale"
        return 1
    fi

    if [[ $view != "Auction" && $view != "Bid" ]]; then
        echo "Invalid view"
        return 1
    fi

    if [[ $count -gt 9 || $count -lt 0 ]]; then
        echo "Invalid count"
        return 1
    fi

    return 0
}

echo "Enter the component name:"
read component_name

echo "Enter the scale:"
read scale

echo "Enter the view:"
read view

echo "Enter the count:"
read count

# Validate the input
if ! validate_input $component_name $scale $view $count; then
    exit 1
fi


sed -i "s/vdopiasample/$view/g" sig.conf
sed -i "s/vdopiasample-bid/$view-bid/g" sig.conf
sed -i "s/MID/$scale/g" sig.conf
sed -i "s/LOW/$count/g" sig.conf
sed -i "s/HIGH/$count/g" sig.conf

# Print the updated file
cat sig.conf
