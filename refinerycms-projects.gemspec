Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = %q{refinerycms-projects}
  s.version           = %q{2.0.0}
  s.date              = %q{2011-12-16}
  s.authors    				= %q{Johan Froelich}
  s.email       			= %q{johan-frolich@hotmail.com}
  s.homepage   			 	= %q{}
  s.description       = %q{Ruby on Rails project engine for Refinery CMS}
  s.summary           = %q{Project engine for Refinery CMS}
  s.require_paths     = %w(lib)
  #s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*', 'public/**/*']
  s.files             = `git ls-files`.split("\n")
  
  s.add_dependency  'refinerycms-core', '~> 2.0.0'
  
  
end
