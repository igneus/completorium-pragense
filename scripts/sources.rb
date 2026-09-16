require 'gly'

parser = Gly::Parser.new

ARGV.each do |f|
  puts "= #{f}"
  parser.parse_fname(f).scores.flat_map do |score|
    ['manuscript', 'manuscript-additional'].flat_map do |field|
      val = score.headers[field]
      if val
        val.split(/\s*;\s*/).collect {|x| x.split(',')[0].sub(/^cf.\s*/i, '') }
      else
        []
      end
    end
  end.uniq.each {|s| puts s }
end
