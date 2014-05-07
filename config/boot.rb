# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

require 'rubygems'

if File.exists?('.env') # Beyond local, '.env' won't exist
  env_lines = File.read(".env").split("\n")
  env_lines.each do |line|
    key, value = line.split("=")
    ENV[key] ||= value
  end
end
