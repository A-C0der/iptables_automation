#!/bin/bash

SOURCE=/etc/sysconfig/update_rule
DEST=/etc/sysconfig/iptables

while IFS= read -r new_rule new_rule2; do
    # Extract Source (-s) and Destination (-d) IPs
    IP=$(echo "$new_rule" | awk '{for (i=1; i<=NF; i++) if ($i == "-s") print $(i+1)}')
    IP2=$(echo "$new_rule" | awk '{for (i=1; i<=NF; i++) if ($i == "-d") print $(i+1)}')

    DIRECTION=$(echo "$new_rule" | awk '{print $2}')
    INPUT_LOG="-A INPUT -j LOG --log-prefix"
    OUTPUT_LOG="-A OUTPUT -j LOG --log-prefix"

    # Extract Ports from the new rule
    NEW_PORTS=$(echo "$new_rule" | sed -n 's/.*--dports \([^ ]*\).*/\1/p')

    # Search for existing rules
    EXISTING_RULE=$(grep -E "\-A $DIRECTION -s $IP" "$DEST")
    EXISTING_RULE2=$(grep -E "\-A $DIRECTION -d $IP2" "$DEST")

    echo "DEBUG: Processing rule: $new_rule"
    echo "DEBUG: IP (-s)=$IP, IP2 (-d)=$IP2"
    echo "DEBUG: Existing Rule (-s)=$EXISTING_RULE"
    echo "DEBUG: Existing Rule (-d)=$EXISTING_RULE2"

    # Function to merge ports without duplicates
    merge_ports() {
        echo "$1,$2" | tr ',' '\n' | sort -u | tr '\n' ',' | sed 's/,$//'
    }

    if [[ -n "$IP" && -n "$EXISTING_RULE" ]]; then
        echo "Updating existing source rule for IP: $IP"
        EXISTING_PORTS=$(echo "$EXISTING_RULE" | sed -n 's/.*--dports \([^ ]*\).*/\1/p')
        FINAL_PORTS=$(merge_ports "$EXISTING_PORTS" "$NEW_PORTS")

        UPDATED_RULE=$(echo "$EXISTING_RULE" | sed "s/--dports [^ ]*/--dports $FINAL_PORTS/")
        echo "DEBUG: Updating $DEST with: $UPDATED_RULE"
        sed -i "s|$EXISTING_RULE|$UPDATED_RULE|" "$DEST"
        echo "Updated rule for Source IP ($IP): $UPDATED_RULE"

    elif [[ -n "$IP2" && -n "$EXISTING_RULE2" ]]; then
        echo "Updating existing destination rule for IP2: $IP2"
        EXISTING_PORTS=$(echo "$EXISTING_RULE2" | sed -n 's/.*--dports \([^ ]*\).*/\1/p')
        FINAL_PORTS=$(merge_ports "$EXISTING_PORTS" "$NEW_PORTS")

        UPDATED_RULE2=$(echo "$EXISTING_RULE2" | sed "s/--dports [^ ]*/--dports $FINAL_PORTS/")
        echo "DEBUG: Updating $DEST with: $UPDATED_RULE2"
        sed -i "s|$EXISTING_RULE2|$UPDATED_RULE2|" "$DEST"
        echo "Updated rule for Destination IP ($IP2): $UPDATED_RULE2"

    else
        echo "Adding new rule..."
        if [[ -n "$IP" ]]; then
            if [[ "$new_rule" == *"-A INPUT -s"* ]]; then
                sed -i "/$INPUT_LOG/i $new_rule" "$DEST"
                echo "Added new INPUT rule: $new_rule"
            elif [[ "$new_rule" == *"-A OUTPUT -s"* ]]; then
                sed -i "/$OUTPUT_LOG/i $new_rule" "$DEST"
                echo "Added new OUTPUT rule: $new_rule"
            fi
        elif [[ -n "$IP2" ]]; then
            if [[ "$new_rule" == *"-A OUTPUT -d"* ]]; then
                sed -i "/$OUTPUT_LOG/i $new_rule" "$DEST"
                echo "Added new OUTPUT rule: $new_rule"
            elif [[ "$new_rule" == *"-A INPUT -d"* ]]; then
                sed -i "/$INPUT_LOG/i $new_rule" "$DEST"
                echo "Added new INPUT rule: $new_rule"
            fi
        else
            echo "Check the rule format."
        fi
    fi
done < "$SOURCE"
