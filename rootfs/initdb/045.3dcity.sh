#!/bin/sh

# Set in parent scripts:
# ---------------------------------------------------------
# set -e +a +m +s +i +f
# VAR_*
# ---------------------------------------------------------

createTemplate(){
   local prio="045"
   local dbname="template_3dcity"
   local sql_file="/initdb/$prio.$dbname.sql"
   echo "CREATE EXTENSION IF NOT EXISTS pgagent;" > "$sql_file"
}

if [ "$VAR_CREATE_EXTENSION_PGAGENT" == "yes" ]
then
   createPgagentExtension
fi
set SRSNO :$VAR_SRSNO
