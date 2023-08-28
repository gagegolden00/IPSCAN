#!/usr/bin/env ruby ## specify inturpreter if you want or run it manually
if ARGV.empty?
  puts "Usage: ruby ping_script.rb <host>"
  exit
end

host = ARGV[0]

instances = 1000

threads = []
mutex = Mutex.new

instances.times do
  threads << Thread.new do
    loop do
      ping_output = `ping -c 1 #{host}`
      puts ping_output
      mutex.synchronize do
        puts "Active Threads: #{Thread.list.count}"
      end
    end
  end
end

threads.each(&:join)
