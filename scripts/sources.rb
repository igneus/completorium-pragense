require 'gly'

# takes a source reference,
# extracts library siglum + signature
def clean_ref(ref)
  ref
    .split(',')[0] # remove folio/page
    .sub(/^cf.\s*/i, '') # remove cf.
end

parser = Gly::Parser.new

ARGV.each do |f|
  puts "= #{f}"
  parser.parse_fname(f).scores.flat_map do |score|
    ['manuscript', 'manuscript-additional'].flat_map do |field|
      score
        .headers[field]
        &.split(/\s*;\s*/)
        &.collect(&method(:clean_ref)) \
      || []
    end
  end.uniq.each {|s| puts s }
end
