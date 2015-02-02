# See https://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "1n"
client_key               "#{current_dir}/1n.pem"
validation_client_name   "privateinc-validator"
validation_key           "#{current_dir}/privateinc-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/privateinc"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]

#copyright
cookbook_copyright "private, inc."
cookbook_email     "vlad.tkatchev@gmail.com"
cookbook_license   "apachev2"