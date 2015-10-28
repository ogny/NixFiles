#!/bin/bash

get_current_modifier()
{
    echo $(TZ=":$1" date +%z --date="$2" 2>/dev/null)
}

get_non_dst_modifier()
{
    echo $(TZ=":$1" date +%z --date="$(date +%Y --date="$2")-01-01" 2>/dev/null)
}

is_dst()
{
    local city=$1
    local date=$2
    local offset1=$(get_non_dst_modifier "${city}" "${date}")
    local offset2=$(get_current_modifier "${city}" "${date}")

    if [ -z "${offset1}" ] || [ -z "${offset2}" ]; then
        return 2
    fi
    [ "${offset1}" != "${offset2}" ]
}

today=$(date +%Y-%m-%d)
printf "%-15s  %-10s  %-5s  %-8s  %-8s\n" CITY DATE 'DST?' 'current' 'non-DST'
while read -r city date; do
    [ -n "${city}" ] || continue
    is_dst "${city}" "${date}"
    case $? in
        0) is_dst=true  ;;
        1) is_dst=false ;;
        2) is_dst=error ;;
    esac
    cur_mod=$(get_current_modifier "${city}" "${date}")
    non_dst=$(get_non_dst_modifier "${city}" "${date}")
    printf "%-15s  %-10s  %-5s  %-8s  %-8s\n" "${city}" "${date}" "${is_dst}" "${cur_mod}" "${non_dst}"
done <<EOT
Europe/Berlin $today
US/Alaska     $today
Europe/Moscow $today
Europe/Moscow 2014-01-01
Europe/Istanbul $today
EOT
