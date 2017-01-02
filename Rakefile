# Usage rake deploy
desc 'Deploy to production'
task :deploy do
  exec 'bundle exec wd deploy --to=production'
end

# Usage: rake notify
task :notify => ["notify:pingomatic", "notify:google", "notify:bing"]
desc "Notify various services that the site has been updated"
namespace :notify do

  # Load in the values from the config file
  require 'yaml'
  require 'uri'
  config = YAML.load_file('_config.yml')
  uri = URI(config['url'])

  desc "Notify Ping-O-Matic"
  task :pingomatic do
    begin
      require 'xmlrpc/client'
      puts "* Notifying Ping-O-Matic that the site has updated"
      XMLRPC::Client.new('rpc.pingomatic.com', '/').call('weblogUpdates.extendedPing', uri.host , "//#{uri.host}", "//#{uri.host}/feed.xml")
    rescue LoadError
      puts "! Could not ping ping-o-matic, because XMLRPC::Client could not be found."
    end
  end

  desc "Notify Google of updated sitemap"
  task :google do
    begin
      require 'net/http'
      require 'uri'
      puts "* Notifying Google that the site has updated"
      Net::HTTP.get('www.google.com', '/webmasters/tools/ping?sitemap=' + URI.escape("//#{uri.host}/sitemap.xml"))
    rescue LoadError
      puts "! Could not ping Google about our sitemap, because Net::HTTP or URI could not be found."
    end
  end

  desc "Notify Bing of updated sitemap"
  task :bing do
    begin
      require 'net/http'
      require 'uri'
      puts '* Notifying Bing that the site has updated'
      Net::HTTP.get('www.bing.com', '/webmaster/ping.aspx?siteMap=' + URI.escape("//#{uri.host}/sitemap.xml"))
    rescue LoadError
      puts "! Could not ping Bing about our sitemap, because Net::HTTP or URI could not be found."
    end
  end
end
