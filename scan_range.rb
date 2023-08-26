#!/usr/bin/env ruby
require 'bundler/setup'
require 'pry'

class IpScan
  def self.scan(input)
    unless detected_input?
      octet_hash = build_octet_hash(input)
      ip = "#{octet_hash[:octet1]}.#{octet_hash[:octet2]}.#{octet_hash[:octet3]}.#{octet_hash[:octet4]}"
      successful_ping_addresses = []

      loop do
        ping_output = `ping -c 1 #{ip}`
        puts "IP: #{ip}"
        puts "STATUS: #{ping_output}"
        
        if ping_successful?
          successful_ping_addresses << ip
        end
        
        octet_hash[:octet4] += 1
        ip = "#{octet_hash[:octet1]}.#{octet_hash[:octet2]}.#{octet_hash[:octet3]}.#{octet_hash[:octet4]}"
        break if octet_hash[:octet4] == 4
      end

      display_successful_pings(successful_ping_addresses)
    end
  end

  private

  def self.detected_input?
    if ARGV.empty?
      puts <<-EOS
Usage: ruby ping_script.rb 192.168.___._
       You will set the first 3 octets and the 
       last will be an iteration from whatever you
       put in up to 255
      EOS
      true
    else
      false
    end
  end

  def self.valid_ipv4?(input)
    pattern = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/

    if input.match(pattern)
      octets = input.split('.').map(&:to_i)
      octets.all? { |octet| octet >= 0 && octet <= 255 }
    else
      puts "Your input was not valid, did not pass valid_ipv4? function."
      false
    end
  end

  def self.build_octet_hash(input)
    if valid_ipv4?(input)
      octets = input.split('.').map(&:to_i)
      octet_hash = {
        octet1: octets[0],
        octet2: octets[1],
        octet3: octets[2],
        octet4: octets[3]
      }
      puts "OCTET_HASH: #{octet_hash}"
      octet_hash
    else 
      puts "failed to build octet_hash"
    end
  end

  def self.ping_successful?
    true # Implement actual logic for success checking here
  end

  def self.display_successful_pings(successful_ping_addresses)
    if !successful_ping_addresses.empty?
      successful_ping_addresses.each do |msg|
        puts msg
      end
    else 
      puts "no successful pings"
    end
  end
end

input = ARGV[0]
IpScan.scan(input) if input



#   IP: 192.168.1.174
# STATUS: PING 192.168.1.174 (192.168.1.174) 56(84) bytes of data.
# From 192.168.1.175 icmp_seq=1 Destination Host Unreachable

# --- 192.168.1.174 ping statistics ---
# 1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms

# IP: 192.168.1.175
# STATUS: PING 192.168.1.175 (192.168.1.175) 56(84) bytes of data.
# 64 bytes from 192.168.1.175: icmp_seq=1 ttl=64 time=0.050 ms

# --- 192.168.1.175 ping statistics ---
# 1 packets transmitted, 1 received, 0% packet loss, time 0ms
# rtt min/avg/max/mdev = 0.050/0.050/0.050/0.000 ms
# IP: 192.168.1.176
# STATUS: PING 192.168.1.176 (192.168.1.176) 56(84) bytes of data.
# From 192.168.1.175 icmp_seq=1 Destination Host Unreachable
