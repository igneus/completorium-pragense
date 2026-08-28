deps = Dir["*/**/*.tex"] + Dir["*.*bx"] + Dir['*.bib']

main = 'completorium_pragense.tex'
main_noext = main.sub '.tex', ''
main_pdf = main.sub '.tex', '.pdf'

desc "build the main product (#{main_pdf})"
task :default => [main_pdf]

file main_pdf => deps + [:gtex] do |t|
  sh 'lualatex', main_noext
  sh 'biber', main_noext
  sh 'lualatex', main_noext
end

# TODO get a list of gabc files in advance, build a proper
#   dependency chain, avoid rebuilding everything always

desc 'generate gabc files from gly files'
task :gabc => Dir['cantus/*.gly'] do |t|
  Dir.chdir('cantus') do
    # make sure the build doesn't rely on zombie files
    rm_f ['*.gabc', '*.gtex']

    sh 'gly', 'gabc', '--suffix-always',
       *t.prerequisites.collect {|f| File.basename f }
  end
end

task :gtex => [:gabc] do
  Dir['cantus/*.gabc'].each do |f|
    Dir.chdir(File.dirname(f)) do
      sh 'gregorio', File.basename(f)
    end
  end
end

desc 'delete LaTeX by-products'
task :clean do
  %w{aux bbl dvi bcf blg log out pdf run.xml *~}.each do |s|
    unless Dir['*.'+s].empty?
      sh "rm *."+s
    end
  end
end
