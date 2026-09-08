# Finds scores matching the specified condition(s)

require 'optparse'
require 'yaml'

require 'gly'

verbose = false
xargs = false

fail_found = false
fail_not_found = false

conditions = []
header_values = {}

OptionParser.new do |opts|
  opts.on '-m', '--matching=CODE', 'piece of Ruby code, variables `x` and `score` refer to the score, variable `header` is available' do |c|
    conditions << c
  end
  opts.on '-H', '--header=YAML', 'YAML mapping of score header fields and values' do |h|
    hdr = YAML.load h
    unless hdr.is_a? Hash
      raise ArgumentError.new('Unexpected argument type, value of --header must be a YAML mapping (hash, dictionary), #{hdr.class} found')
    end
    header_values.update hdr
  end

  opts.separator 'Output'
  opts.on '-v', '--verbose', 'verbose output' do
    verbose = true
  end
  opts.on '-x', '--xargs', 'output score FIALs arranged in a way suitable for being fed to xargs' do
    xargs = true
  end

  opts.separator 'Exit status'
  opts.on '-f', '--fail-if-found', 'exit(1) if any matching score is found' do
    fail_found = true
  end
  opts.on '-F', '--fail-if-not-found', 'exit(1) if no matching score is found' do
    fail_not_found = true
  end
end.parse!

matches_conditions = lambda do |x|
  score = x
  headers = x.headers
  music = x.music

  #header_values <= x.headers &&
    conditions.all? {|c| eval c }
end

parser = Gly::Parser.new

found = 0
ARGV.each do |path|
  found_in_path = false

  parser.parse_fname(path).scores.each do |score|
    id = score.headers['id']

    if matches_conditions.call(score)
      found += 1
      if verbose && !found_in_path
        puts "= #{path}"
        puts
        found_in_path = true
      end

      if xargs
        puts "#{path}##{id}"
      else
        puts "#{path}##{id} #{score.lyrics.readable}"
      end

      if verbose
        puts
        puts score.text
        puts
      end
    end
  end

  puts if verbose && found_in_path
end

unless xargs
  puts
  puts "Found #{found} matching scores."
end

exit(1) if fail_found && found > 0
exit(1) if fail_not_found && found == 0
