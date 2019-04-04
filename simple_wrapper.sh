#!/usr/bin/env bash
# Simple wrapper for Nagios/Icinga/OP5 plugins.
# Henrik Janzon <hjanzon@op5.com>

# Variables
PLUGIN=/opt/plugins/check_xxxxx.pl

OUTPUT=$($PLUGIN $* 2>&1)
RC=$?

# Help message function
help()
{
cat << EOF
################
WRAPPER PLUGIN $0
################
EOF
}

# Add info to the wrapped plugins help pages.
if [ "$1" == "--help" ] ||  [ $# == 0 ]; then
  help
fi

# Modifications, edit for desired requirements
# This sample removes new lines from output if state equals warning or critical
if [ $RC == 1 ] || [ $RC == 2 ]; then
  OUTPUT=$(echo $OUTPUT | tr -d '\n')
fi

# Exit
echo "$OUTPUT"
exit $RC
