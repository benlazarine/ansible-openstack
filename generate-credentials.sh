#!/bin/bash

# Getops example: http://mywiki.wooledge.org/BashFAQ/035

#########
# Usage #
#########
show_help() {
cat << EOF

Usage: ${0##*/} [-h] [-y] [-i INPUTFILE] [-p PASSWORD_LENGTH] ...

Generate OpenStack credentials for this installation.

    -h                  display this help and exit
    -i INPUTFILE        password input file used to generate selected passwords.
    -p PASSWORD_LENGTH  password length for MySQL passwords.
    -y                  automatically encrypt file using Ansible Vault.

EOF
}

########################
# Initialize variables #
########################
encrypt_flag=false
input_file=""
pass_length=0
output_file="openstack-liberty-creds.yml"
vault_key=".vault_pass.txt"

###################
# Perform cleanup #
###################
rm -f $output_file $vault_key

###########
# Getopts #
###########
OPTIND=1 # Reset is necessary if getopts was used previously in the script.  It is a good idea to make this local in a function.
while getopts "hyi:l:" opt; do
    case "$opt" in
        h)
            show_help
            exit 0
            ;;
        i)  input_file=$OPTARG
            ;;
        l)	pass_length=$OPTARG
			;;
        y)  encrypt_flag=true
            ;;
        '?')
            show_help >&2
            exit 1
            ;;
    esac
done
shift "$((OPTIND-1))" # Shift off the options and optional --.

####################################
# Set defaults for input variables #
####################################
if [[ $input_file == "" ]]; then
	input_file="openstack-creds.txt"
fi

if [[ $pass_length == 0 ]]; then
	pass_length=20
fi

echo $(pwgen $pass_length) > $vault_key

##################################
# Generate OpenStack Credentials #
##################################
while read p; do
	if [[ $p == *"MYSQL_PASS_"* ]]; then
		echo "$p: $(pwgen ${pass_length})" >> $output_file
	else
		echo "$p: $(openssl rand -hex 10)" >> $output_file
	fi
done < $input_file

#########################
# Encrypt Ansible Vault #
#########################
if $encrypt_flag ; then
    ansible-vault encrypt $output_file --vault-password-file .vault_pass.txt
else
    echo "Password file is in plain text."
fi

exit 0