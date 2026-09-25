deps = Dir["*/**/*.tex"] + Dir["*.*bx"] + Dir['*.bib']

main = 'completorium_pragense.tex'
main_noext = main.sub '.tex', ''
main_pdf = main.sub '.tex', '.pdf'

def lualatex(*args)
  sh 'lualatex', '--shell-escape', *args
end

desc "build the main product (#{main_pdf})"
task :default => [main_pdf]

file main_pdf => deps + [:gtex, :psalms, :hymns] do |t|
  lualatex main_noext
  sh 'biber', main_noext
  lualatex main_noext
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
  file target => [source, 'scripts/psalm.rb', 'scripts/initial.rb'] do |t|
    sh "ruby scripts/psalm.rb #{source} | ruby scripts/initial.rb > #{target}"
  end
end

hymns_src = Dir['hymni/*.txt']
hymns_target = hymns_src.collect {|f| f.sub('.txt', '.tex') }
task :hymns => hymns_target

hymns_target.zip(hymns_src).each do |(target, source)|
  file target => [source, 'scripts/initial.rb'] do |t|
    sh "ruby scripts/initial.rb #{source} > #{target}"
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

desc 'list sources'
task :sources do
  ruby 'scripts/sources.rb', *Dir['cantus/*.gly'].sort
end

desc 'run checks'
task :check do
  [
    # at most two sources printed with the score
    'headers["manuscript"]&.yield_self {|m| m.split(";").size > 2 }',
    # manuscript reference format: no "folio" abbreviation
    'headers["manuscript"]&.include? " f. "',
    # each score (which has an annotation) has a standard office-part
    '!headers["annotation"].nil? && headers["office-part"].yield_self {|t| !["antiphona", "responsorium prolixum", "hymnus", "tropus", "versiculus", "benedicamus"].include?(t) }',
  ].each do |expr|
    ruby 'scripts/find_scores.rb',
         '--fail-if-found',
         '-m', expr,
         *Dir['cantus/*.gly']
  end

  sh 'grep',
     '--recursive',
     '--exclude-from=.gitignore',
     '--extended-regexp',
     '--color',
     ('coe' + # caelum, not coelum
      '|\\\\label'), # always use \pslabel instead of \label
     'partes', 'hymni', 'psalmi', 'cantus'
end
