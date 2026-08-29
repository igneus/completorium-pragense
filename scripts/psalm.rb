ARGF.each_line($/, chomp: true) do |l|
  print l
  print "\\\\" unless l.end_with? ':'
  puts
end
