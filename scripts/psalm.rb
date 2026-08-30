def strip_tex_comment s
  s.sub(/\s*%.*$/, '')
end

ARGF.each_line($/, chomp: true) do |l|
  print l
  puts unless strip_tex_comment(l).end_with? ':'
  puts
end
