default[:mysql][:version] = "5.6.13"

default[:mysql][:port]    = "3306"
default[:mysql][:socket]  = "/var/lib/mysql/mysql.sock"

default[:mysql][:long_query_time] = "1"
default[:mysql][:slow_query_log_file] = "/var/log/mysql/slow.log"

default[:mysql][:binlog_format] = "mixed"
default[:mysql][:expire_logs_days] = "7"

default[:mysql][:sync_binlog] = "1"
default[:mysql][:server_id]   = "1"

default[:mysql][:slave_host]     = "127.0.0.1"
default[:mysql][:slave_user]     = "repl"
default[:mysql][:slave_password] = "repl"

default[:mysql][:innodb_buffer_pool_size] = "256M"
default[:mysql][:innodb_log_buffer_size]  = "16M"
default[:mysql][:innodb_log_file_size]    = "64M"



