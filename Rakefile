require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs = %w[lib test]
  t.pattern = 'test/**/*_test.rb'
end

namespace :server do
  desc 'start a http server'
  task :start do
    require './lib/http_server'

    server = HttpServer.new port: 5000
    server.start
  end
end
