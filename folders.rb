#!/usr/bin/env ruby

# Lists folders to help you with the migration

require 'yaml'
require 'net/imap'

if $PROGRAM_NAME == __FILE__
  require 'yaml'
  unless ARGV.empty?
    require 'open-uri'
    begin
      C = YAML.load(open(ARGV[0]))
    rescue
      raise "Unable to fetch configuration file."
    end
  else
    C = YAML.load(File.read('configuration.yml'))
  end
end

source = Net::IMAP.new(C['source']['host'], C['source']['port'], C['source']['ssl'])
source.login(C['source']['username'], C['source']['password'])

dest = Net::IMAP.new(C['destination']['host'], C['destination']['port'], C['destination']['ssl'])
dest.login(C['destination']['username'], C['destination']['password'])


puts "Source Folders:"
puts source.list('', '*').map(&:name)
puts "\n\n"
puts "Destination Folders:"
puts dest.list('', '*').map(&:name)


