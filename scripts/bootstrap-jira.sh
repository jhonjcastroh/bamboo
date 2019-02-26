#!/bin/bash

set -o xtrace

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../

# Generate a random password.
PASSWD=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
SALT=`< /dev/urandom tr -dc A-Za-z0-9 | head -c16`

# Prepare group_vars/all.
TMP_VARS=`mktemp`
echo -e "# Updated on `date`" >> $TMP_VARS
find roles/*/defaults/*.yml -type f -exec cat {} \; | egrep -e '^\w*:' | sort -u | sed 's/^/#/g;s/\[$/[]/g;s/{$/{}/g' >> $TMP_VARS
echo -en '\n' >> $TMP_VARS
perl -i -p -e "s/^#(apache2_http_port):.*/\1: \"80\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_https_port):.*/\1: \"443\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_document_root):.*/\1: ~/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_gid):.*/\1: ~/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_hash_salt):.*/\1: \"$SALT\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_home):.*/\1: \"\/var\/lib\/jira\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_http_port):.*/\1: \"{{ apache2_http_port }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_https_port):.*/\1: \"{{ apache2_https_port }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_id):.*/\1: \"jira\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_pass):.*/\1: \"$PASSWD\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_proxy_pass):.*/\1: \"\/   http:\/\/localhost:{{ jira_connector_port }}\/\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_proxy_pass_reverse):.*/\1: \"\/   http:\/\/localhost:{{ jira_connector_port }}\/\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_proxy_preserve_host):.*/\1: \"Off\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_proxy_request):.*/\1: \"On\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_proxy_via):.*/\1: \"On\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_server_alias):.*/\1: []/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_server_name):.*/\1: \"jira.example.com\"/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_uid):.*/\1: ~/g" $TMP_VARS
perl -i -p -e "s/^#(apache2_vhosts_user):.*/\1: \"jira\"/g" $TMP_VARS
perl -i -p -e "s/^#(apt_cache_valid_time):.*/\1: \"3600\"/g" $TMP_VARS
perl -i -p -e "s/^#(apt_upgrade):.*/\1: \"full\"/g" $TMP_VARS
perl -i -p -e "s/^#(jira_connector_port):.*/\1: \"8080\"/g" $TMP_VARS
perl -i -p -e "s/^#(jira_gid):.*/\1: \"{{ apache2_vhosts_gid }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(jira_hash_salt):.*/\1: \"{{ apache2_vhosts_hash_salt }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(jira_home):.*/\1: \"{{ apache2_vhosts_home }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(jira_pass):.*/\1: \"{{ apache2_vhosts_pass }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(jira_proxy_name):.*/\1: \"{{ apache2_vhosts_server_name }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(jira_scheme):.*/\1: \"http\"/g" $TMP_VARS
perl -i -p -e "s/^#(jira_server_port):.*/\1: \"8005\"/g" $TMP_VARS
perl -i -p -e "s/^#(jira_uid):.*/\1: \"{{ apache2_vhosts_uid }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(jira_user):.*/\1: \"{{ apache2_vhosts_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_connector_java_dest):.*/\1: \"\/usr\/share\/jira\/lib\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_connector_java_user):.*/\1: \"{{ apache2_vhosts_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_port):.*/\1: \"3306\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_root_pass):.*/\1: \"$PASSWD\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_vhosts_collation):.*/\1: \"utf8_bin\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_vhosts_encoding):.*/\1: \"utf8\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_vhosts_id):.*/\1: \"{{ apache2_vhosts_id }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_vhosts_pass):.*/\1: \"{{ apache2_vhosts_pass }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(mysql_vhosts_user):.*/\1: \"{{ apache2_vhosts_user }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_port):.*/\1: \"5432\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_encoding):.*/\1: \"UTF8\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_id):.*/\1: \"{{ apache2_vhosts_id }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_lc_collate):.*/\1: \"C\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_lc_ctype):.*/\1: \"C\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_pass):.*/\1: \"{{ apache2_vhosts_pass }}\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_template):.*/\1: \"template0\"/g" $TMP_VARS
perl -i -p -e "s/^#(postgresql_vhosts_user):.*/\1: \"{{ apache2_vhosts_user }}\"/g" $TMP_VARS
cat $TMP_VARS >> host_vars/jira.aio
