require 'rubygems'
require 'rake/gempackagetask'
require './lib/turd/version.rb'

spec = Gem::Specification.new do |s|
  s.name = "turd"
  s.version = Turd::VERSION
  s.author = "joe williams"
  s.email = "joe@joetify.com"
  s.homepage = "http://github.com/joewilliams/turd"
  s.platform = Gem::Platform::RUBY
  s.summary = "a http and tcp testing lib"
  s.files = FileList["{lib}/**/*"].to_a
  s.require_path = "lib"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.md"]
  %w{typhoeus}.each { |gem| s.add_dependency gem }
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end
