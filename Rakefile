deps = Dir['*.tex'] + Dir["*/**/*.tex"] + Dir["*.*bx"] + Dir['*.bib'] + Dir['*/**/*.gly']

main = Dir['*.tex'].first # only one expected
main_noext = main.sub '.tex', ''
main_pdf = main.sub '.tex', '.pdf'

file main_pdf => deps do |t|
  Dir['*/**/*.gly'].each do |f|
    Dir.chdir(File.dirname(f)) do
      sh 'gly', 'preview', File.basename(f)
    end
  end

  sh 'lualatex', main_noext
  sh 'biber', main_noext
  sh 'lualatex', main_noext
end

task :default => [main_pdf]

desc "smazat vedlejsi produkty sazby latexem"
task :clean do
  %w{aux bbl dvi bcf blg log out pdf run.xml *~}.each do |s|
    unless Dir['*.'+s].empty?
      sh "rm *."+s
    end
  end
end
