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
