Gem::Specification.new do |s|
  s.name        = 're_director'
  s.version     = '0.0.1'
  s.date        = '2017-09-07'
  s.summary     = 'SEP redirector'
  s.description = 'Contenido redirection app'
  s.authors     = ['Alex Timofeev']
  s.email       = 'atimofeev@saberespoder.com'
  s.files       = ["lib/re_director.rb"]
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/saberespoder/re_director'

  s.add_runtime_dependency 'roda', '2.29.0'
end
