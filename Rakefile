require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "providence"
  gem.homepage = "http://github.com/ccollins/providence"
  gem.license = "MIT"
  gem.summary = %Q{Ready made watchr files for rails projects using rspec and cucumber}
  gem.description = %Q{Ready made watchr files for rails projects using rspec and cucumber.  Beware the growl.  Only tested on OSX.}
  gem.email = "chuck.collins@gmail.com"
  gem.authors = ["Chuck Collins"]
  gem.bindir = "bin"
  gem.executables = "prov"
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  #  gem.add_runtime_dependency 'jabber4r', '> 0.1'
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
  
  gem.add_dependency 'growl'
  gem.add_dependency 'rb-fsevent'
  gem.add_dependency 'watchr'  
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'rcov'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "providence #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
