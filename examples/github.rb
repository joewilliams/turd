require "../lib/turd"
require 'pp'

# normal http

request_definition = {
  :id => "github.com blah blah",
  :type => "http",
  :url => "https://github.com/",
  :options => {
    :method => :get
  }
}

response_definition = {
  :response_code => 200
}

puts "running #{request_definition[:type]} test #{request_definition[:id]} ..."

result = Turd.run(request_definition, response_definition)

result.options.delete(:response_headers)
result.options.delete(:response_body)

puts "******* here's some http response data (partial) you can use"
PP.pp result.options
puts "*******"
puts

# svn+http

request_definition = {
  :id => "github.com svn",
  :type => "http",
  :url => "https://github.com/tmm1/rbtrace/!svn/bc/1",
  :options => {
    :headers => {"user-agent" => 'SVN/1.7.10 neon/0.29.6 turd/0.1'},
    :body => "<?xml version='1.0' encoding='utf-8'?><propfind xmlns=\"DAV:\"><allprop/></propfind>",
    :method => :propfind
  }
}

response_definition = {
  :response_code => 207,
  :response_body => ["aman"]
}

puts "running #{request_definition[:type]} test #{request_definition[:id]} ..."

Turd.run(request_definition, response_definition)


# git+http

request_definition = {
  :id => "github.com git upload pack",
  :type => "http",
  :url => "https://github.com/tmm1/rbtrace/info/refs?service=git-upload-pack",
  :options => {
    :headers => {"user-agent" => "git/1.8.2 turd/0.1"},
    :method => :get,
  }
}

response_definition = {
  :response_code => 200,
  :response_headers => ["Content-Type: application/x-git-upload-pack-advertisement"],
  :response_body => ["003f62998e62735538453fc434e5243ee09635c828bb refs/pull/12/head"]
}

puts "running #{request_definition[:type]} test #{request_definition[:id]} ..."

Turd.run(request_definition, response_definition)


# ssh

request_definition = {
  :id => "github.com ssh tcp",
  :type => "tcp",
  :options => {
    :host => "github.com",
    :port => "22"
  }
}

response_definition = {
  :response => ["SSH-2.0"]
}

puts "running #{request_definition[:type]} test #{request_definition[:id]} ..."

result = Turd.run(request_definition, response_definition)

puts "******* here's some tcp response data you can use"
PP.pp result
puts "*******"