# Run clear if you want to delete existing data before loading
 virtuoso-run-script.sh clear_graph.sql
 
# Disabling auto-indexing makes loading faster
 virtuoso-run-script.sh auto_indexing_disable.sql
 
# You need to adapt the folders in the script
 virtuoso-run-script.sh load_data.sql
 
# Run loader in parallel
 virtuoso-run-script.sh bulk_run.sql &
 virtuoso-run-script.sh bulk_run.sql &
 virtuoso-run-script.sh bulk_run.sql &
 virtuoso-run-script.sh bulk_run.sql &
 virtuoso-run-script.sh bulk_run.sql &
 wait
 
# Commmit WORK
 virtuoso-run-script.sh commit.sql

# Renable auto-indexing once finished with bulk operations
 virtuoso-run-script.sh auto_indexing_enable.sql
