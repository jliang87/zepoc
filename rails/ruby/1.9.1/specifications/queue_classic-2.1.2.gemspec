# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "queue_classic"
  s.version = "2.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Smith (\u{2660} ace hacker)"]
  s.date = "2013-01-02"
  s.description = "queue_classic is a queueing library for Ruby apps. (Rails, Sinatra, Etc...) queue_classic features asynchronous job polling, database maintained locks and no ridiculous dependencies. As a matter of fact, queue_classic only requires pg."
  s.email = "ryan@heroku.com"
  s.homepage = "http://github.com/ryandotsmith/queue_classic"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "postgres backed queue"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pg>, ["~> 0.14.1"])
    else
      s.add_dependency(%q<pg>, ["~> 0.14.1"])
    end
  else
    s.add_dependency(%q<pg>, ["~> 0.14.1"])
  end
end
