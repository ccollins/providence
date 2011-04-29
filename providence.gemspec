# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{providence}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chuck Collins"]
  s.date = %q{2011-04-29}
  s.default_executable = %q{prov}
  s.description = %q{Ready made watchr files for rails projects using rspec and cucumber.  Beware the growl.  Only tested on OSX.}
  s.email = %q{chuck.collins@gmail.com}
  s.executables = ["prov"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".document",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "bin/prov",
    "features/startup.feature",
    "images/glass/alert.png",
    "images/glass/fail.png",
    "images/glass/info.png",
    "images/glass/pass.png",
    "images/glass/pending.png",
    "lib/providence.rb",
    "lib/providence/base_watchr.rb",
    "lib/providence/cucumber_watchr.rb",
    "lib/providence/event_handlers/darwin.rb",
    "lib/providence/eye.rb",
    "lib/providence/rspec_watchr.rb",
    "providence.gemspec",
    "spec/lib/providence/base_watchr_spec.rb",
    "spec/lib/providence/cucumber_watchr_spec.rb",
    "spec/lib/providence/event_handlers/darwin_spec.rb",
    "spec/lib/providence/eye_spec.rb",
    "spec/lib/providence/rspec_watchr_spec.rb",
    "spec/spec_helper.rb",
    "watchrs/rails.watchr"
  ]
  s.homepage = %q{http://github.com/ccollins/providence}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ready made watchr files for rails projects using rspec and cucumber}
  s.test_files = [
    "spec/lib/providence/base_watchr_spec.rb",
    "spec/lib/providence/cucumber_watchr_spec.rb",
    "spec/lib/providence/event_handlers/darwin_spec.rb",
    "spec/lib/providence/eye_spec.rb",
    "spec/lib/providence/rspec_watchr_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<growl>, [">= 0"])
      s.add_runtime_dependency(%q<rb-fsevent>, [">= 0"])
      s.add_runtime_dependency(%q<watchr>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_runtime_dependency(%q<growl>, [">= 0"])
      s.add_runtime_dependency(%q<rb-fsevent>, [">= 0"])
      s.add_runtime_dependency(%q<watchr>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<growl>, [">= 0"])
      s.add_dependency(%q<rb-fsevent>, [">= 0"])
      s.add_dependency(%q<watchr>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<growl>, [">= 0"])
      s.add_dependency(%q<rb-fsevent>, [">= 0"])
      s.add_dependency(%q<watchr>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<growl>, [">= 0"])
    s.add_dependency(%q<rb-fsevent>, [">= 0"])
    s.add_dependency(%q<watchr>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<growl>, [">= 0"])
    s.add_dependency(%q<rb-fsevent>, [">= 0"])
    s.add_dependency(%q<watchr>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end
