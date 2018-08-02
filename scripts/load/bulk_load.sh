# Run clear if you want to delete existing data before loading
sh virtuoso-run-script.sh clear_graph.sql
 
# Disabling auto-indexing makes loading faster
sh virtuoso-run-script.sh auto_indexing_disable.sql
 
# You need to adapt the folders in the script
sh virtuoso-run-script.sh load_data.sql
 
# Run loader in parallel
sh virtuoso-run-script.sh bulk_run.sql &
 wait
 
# Commmit WORK
sh virtuoso-run-script.sh commit.sql

# Renable auto-indexing once finished with bulk operations
sh virtuoso-run-script.sh auto_indexing_enable.sql

# Turn off virtuoso service
sh virtuoso-run-script.sh shutdown.sql
