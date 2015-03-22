Gem::Specification.new do |s|
  s.name        = 'genetica'
  s.version     = '0.0.1'
  s.date        = '2015-03-22'
  s.summary     = 'The Ruby Genetic Algorithms Gem.'
  s.description = 'Genetica is a library to create and use Genetics Algorithms with Ruby.'
  s.author      = 'José Francisco Calvo'
  s.email       = 'josefranciscocalvo@gmail.com'
  s.files       = Dir['lib/*.rb', 'lib/genetica/*.rb']
  s.test_files  = Dir['spec/*.rb']
  s.homepage    = 'http://dev.monsterzen.com/projects/genetica.html'
  s.required_ruby_version = '>= 2.0.0'
  s.add_development_dependency 'rspec', '~> 3.0'
end
