#!/usr/bin/env ruby
require File.expand_path('../refinery/projects/version', __FILE__)

files = Dir.glob("**/*").flatten.reject do |file|
  file =~ /\.gem$/
end

gemspec = << EOF
Gem::Specification.new do |s|
  s.name              = %q{refinerycms-projects}
  s.version           = %q{#{Refinery::Projects::VERSION}}
  s.date              = %q{#{Time.now.strftime('%Y-%m-%d')}}
  s.summary           = %q{Inquiry handling functionality for the Refinery CMS project.}
  s.description       = %q{Inquiry handling functionality extracted from Refinery CMS to allow you to have a contact form and manage inquiries in the Refinery backend.}
  s.homepage          = %q{http://refinerycms.com}
  s.email             = %q{info@refinerycms.com}
  s.authors           = ["Resolve Digital"]
  s.require_paths     = %w(lib)

  s.add_dependency  'refinerycms-core', '~> 2.0.0'

  s.files             = [
    '#{files.join("',\n    '")}'
  ]
  s.require_path = 'lib'
end
EOF

File.open(File.expand_path("../../refinerycms-projects.gemspec", __FILE__), 'w').puts(gemspec)