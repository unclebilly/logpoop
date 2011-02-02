# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{logpoop}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Billy Reisinger"]
  s.date = %q{2011-02-02}
  s.default_executable = %q{logpoop}
  s.description = %q{This gem installs a script called 'logpoop' that, when run, fills up your active terminal sessions with crap (so that you look really busy). }
  s.email = %q{billy.reisinger@gmail.com}
  s.executables = ["logpoop"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/logpoop",
    "lib/logpoop.rb",
    "test/helper.rb",
    "test/test_logpoop.rb"
  ]
  s.homepage = %q{http://github.com/unclebilly/logpoop}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  s.summary = %q{Quick, look busy! Print some poop in your terminals!}
  s.test_files = [
    "test/helper.rb",
    "test/test_logpoop.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
    else
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    end
  else
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
  end
end

