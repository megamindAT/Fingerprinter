
require 'optparse'

@options = {
  verbose:    false,
  db_verbose: false,
  update:     false
}

OptionParser.new("Usage: ruby #{$PROGRAM_NAME} [options]", 50) do |opts|
  opts.on('--app-name APPLICATION', '-a', 'The application to fingerprint. Currently supported: wordpress') do |app|
    if %w(wordpress).include?(app.downcase)
      @options[:app] = app.downcase
    else
      fail "The application #{app} is not supported"
    end
  end

  opts.on('--db PATH-TO-DB', '-d', 'Path to the db of the app-name') do |db|
    @options[:db] = db
  end

  opts.on('--update', '-u', 'Update the db of the app-name') do
    @options[:update] = true
  end

  opts.on('--show-unique-fingerprints VERSION', '--suf', 'Output the unique file hashes for the given version of the app-name') do |version|
    @options[:version] = version
  end

  opts.on('--search-hash HASH', '--sh', 'Search the hash and output the app-name versions & file') do |hash|
    @options[:hash] = hash
  end

  opts.on('--search-file RELATIVE-FILE-PATH', '--sf', 'Search the file and output the app-name versions & hashes') do |file|
    @options[:file] = file
  end

  opts.on('--fingerprint URL', 'Fingerprint the app-name at the given URL using all fingerprints') do |url|
    @options[:app_url] = url
  end

  opts.on('--unique-fingerprint URL', '--uf' 'Fingerprint the app-name at the given URL using unique fingerprints') do |url|
    @options[:app_url] = url
    @options[:unique]  = true
  end

  opts.on('--db-verbose', '--dbv', 'Database Verbose Mode') do
    @options[:db_verbose] = true
  end

  opts.on('--verbose', '-v', 'Verbose Mode') do
    @options[:verbose] = true
  end
end.parse!
