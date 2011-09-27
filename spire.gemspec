# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "spire"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Nicol"]
  s.date = "2011-09-27"
  s.description = "Light rack-based framework with controllers, static views and a router \n    with templating engine support coming soon"
  s.email = "scott@scottnicol.co.uk"
  s.executables = ["spire"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/spire",
    "config.ru",
    "lib/spire.rb",
    "lib/spire/class/MainController.rb",
    "lib/spire/http.rb",
    "lib/spire/router.rb",
    "spire.gemspec",
    "test/helper.rb",
    "test/test_spire.rb"
  ]
  s.homepage = "http://github.com/snicol/spire"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "A light controller-only rack framework with a dash of views"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 1.3.0"])
      s.add_runtime_dependency(%q<haml>, [">= 3.1.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<rack>, [">= 1.3.0"])
      s.add_dependency(%q<haml>, [">= 3.1.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 1.3.0"])
    s.add_dependency(%q<haml>, [">= 3.1.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

