#!/usr/bin/env ruby ## specify inturpreter if you want or run it manually
# if ARGV.empty?
#   puts "Usage: ruby ping_script.rb 192.168.___._
#         You will set the first 3 octets and the 
#         last will be an iteration from whatever you
#         put in up to 255"
#   exit
# end



# take input from argv
# create base 3 octets

# take last number(s) in last octet (regex)
# LOOP BEGINS
  # convert to integer
  # += 1 on last_octet
  # convert back to string
  # rebuild ip address
  # ping ip address
  # return success on "this ip"
  # continue loop  

  class IpScan
    def self.scan(host)
      if valid_ipv4?(host)
        octets = host.split('.').map(&:to_i)
        puts octets
      else
        puts "Invalid IPv4 address."
      end
    end
  
    private
  
    def self.valid_ipv4?(host)
      pattern = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
  
      if host.match(pattern)
        octets = host.split('.').map(&:to_i)
        return octets.all? { |octet| octet >= 0 && octet <= 255 }
      else
        puts "Your input was not valid, did not pass valid_ipv4? function."
        return false
      end
    end
  end
  
  host = ARGV[0]
  IpScan.scan(host) if host
  

  
  
























# instances = starting_octet

# threads = []
# mutex = Mutex.new

# instances.times do
#   threads << Thread.new do
#     loop do
#       ping_output = `ping -c 1 #{}`
#       puts ping_output
#       mutex.synchronize do
#         puts "Active Threads: #{Thread.list.count}"
#       end
#     end
#   end
# end

# threads.each(&:join)
 