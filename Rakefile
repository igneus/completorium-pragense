deps = Dir["*/**/*.tex"] + Dir["*.*bx"] + Dir['*.bib']

main = 'completorium_pragense.tex'
main_noext = main.sub '.tex', ''
main_pdf = main.sub '.tex', '.pdf'

desc "build the main product (#{main_pdf})"
task :default => [main_pdf]

file main_pdf => deps + [:gtex, :psalms] do |t|
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

psalms_src = Dir['psalmi/*.txt']
psalms_target = psalms_src.collect {|f| f.sub('.txt', '.tex') }

task :psalms => psalms_target

psalms_target.zip(psalms_src).each do |(target, source)|
  file target => [source, __FILE__] do |t|
    cp source, target
    ruby '-p', '-i',
         '-e', '$_ += "\n" unless $_.strip.end_with? ":"',
         target
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
