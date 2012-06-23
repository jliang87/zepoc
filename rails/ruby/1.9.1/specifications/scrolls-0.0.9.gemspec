# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "scrolls"
  s.version = "0.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Heroku"]
  s.date = "2012-04-25"
  s.description = "Logging, easier, more consistent."
  s.email = ["curt@heroku.com"]
  s.homepage = "https://github.com/asenchi/scrolls"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "When do we log? All the time."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
