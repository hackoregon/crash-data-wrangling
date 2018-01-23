-- Foreign Server: odot_crash_data_server

-- DROP SERVER odot_crash_data_server

CREATE SERVER odot_crash_data_server
    FOREIGN DATA WRAPPER ogr_fdw
    OPTIONS (datasource 'ODBC:odot_crash_data_dsn');


ALTER SERVER odot_crash_data_server
    OWNER TO postgres;