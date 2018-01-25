SELECT 
 'CREATE TABLE odot_crash_data_export.', table_name, 
 ' AS SELECT * FROM odot_crash_data_schema.', table_name, ';'
 FROM information_schema.tables 
 WHERE table_schema = 'odot_crash_data_schema';
