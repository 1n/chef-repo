name "httpd"
description "httpd role initial configuration"
run_list "role[base]", "recipe[httpd-wrapper::default]"