require 'date'
require File.expand_path("../lib/logpoop/version", __FILE__)
Gem::Specification.new do |s|
  s.name = "logpoop"
  s.version = Logpoop::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Billy Reisinger"]
  s.date = Date.today
  s.description = "This gem installs a script called 'logpoop' that, when run, fills up your active terminal sessions with crap (so that you look really busy). "
  s.email = "billy.reisinger@gmail.com"
  s.executables = ["logpoop"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]

  s.files = [
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "logpoop.gemspec",
    "test/helper.rb",
    "test/test_logpoop.rb"
  ].concat(Dir["lib/**/**"])
  s.homepage = "http://github.com/unclebilly/logpoop"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Quick, look busy! Print some poop in your terminals!"
  s.test_files = [
    "test/helper.rb",
    "test/test_logpoop.rb"
  ]
end

