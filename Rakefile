require 'bundler/setup'

require 'rubygems'
require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/file_storage'
require 'google/api_client/auth/installed_app'
require 'google_drive'
require 'json'
require 'fileutils'

task :default => [:list]

desc 'Lists all the tasks'
task :list do
  puts "Tasks: \n- #{(Rake::Task.tasks).join("\n- ")}"
end

desc 'Update cookbooks from google drive spreadsheet'
task :update_cookbook do
  $LOAD_PATH.unshift File.dirname(__FILE__)
  API_VERSION = 'v2'
  CACHED_API_FILE = "drive-#{API_VERSION}.cache"
  CREDENTIAL_STORE_FILE = '.chef/secrets/client-secrets-oauth2.json'

  def setup()
    client = Google::APIClient.new(:application_name => 'google spreadsheet do databag',
                                   :application_version => '1.0.0')
    file_storage = Google::APIClient::FileStorage.new(CREDENTIAL_STORE_FILE)
    if file_storage.authorization.nil?
      client_secrets = Google::APIClient::ClientSecrets.load

      flow = Google::APIClient::InstalledAppFlow.new(
          :client_id => client_secrets.client_id,
          :client_secret => client_secrets.client_secret,
          :scope => ['https://www.googleapis.com/auth/drive' + 'https://spreadsheets.google.com/feeds/']
      )
      client.authorization = flow.authorize(file_storage)
    else
      client.authorization = file_storage.authorization
    end

    return client
  end

  client = setup()
  session = GoogleDrive.login_with_oauth(client)

  #print 'Enter your databag google drive spreadsheet link: '
  #google_drive_spreadsheet_link = gets.chomp
  google_drive_spreadsheet_link = 'https://docs.google.com/spreadsheets/d/1-Neg9oHdgOikqeLXqCPbTPSwaR4dUtVHqktv-Ou-3TE/edit#gid=0'# if google_drive_spreadsheet_link.empty?
  ws = session.spreadsheet_by_url(google_drive_spreadsheet_link).worksheets[0]

  #print 'Enter desired databag name(leave empty to use spreadsheet title as databag name): '
  #data_bag_name = gets.chomp
  data_bag_name = ws.title# if data_bag_name.empty?
  FileUtils.mkdir_p("data_bags/#{data_bag_name}") unless File.exist?(data_bag_name) and File.directory?(data_bag_name)

  for row in 2..ws.num_rows
    data_bag_item = Hash.new
    for col in 1..ws.num_cols
      data_bag_item[ws[1, col].to_sym] = ws[row, col]
    end
    p data_bag_item
    databag_item_json_path="data_bags/#{data_bag_name}/#{data_bag_item[:user_name]}.json"

    File.new(databag_item_json_path, 'w+')
    File.open(databag_item_json_path, 'w') { |file| file.write(JSON.pretty_generate(data_bag_item, :indent => "\t")) }
  end

end