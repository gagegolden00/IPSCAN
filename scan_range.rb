#!/usr/bin/env ruby
require 'bundler/setup'
require 'pry'

class IpScan
  def self.scan(input)
    octet_hash = build_octet_hash(input)
    range = input[1].to_i


    ip = "#{octet_hash[:octet1]}.#{octet_hash[:octet2]}.#{octet_hash[:octet3]}.#{octet_hash[:octet4]}"
    successful_ping_addresses = []

    loop do
      ip = "#{octet_hash[:octet1]}.#{octet_hash[:octet2]}.#{octet_hash[:octet3]}.#{octet_hash[:octet4]}"
      ping_output = `ping -c 1 #{ip}`
      puts ping_output
      successful_ping_addresses << ip if ping_successful?(ping_output)

      octet_hash[:octet4] += 1
      break if octet_hash[:octet4] > range
    end


    display_successful_pings(successful_ping_addresses)
  end

  def self.detected_input?
    if !ARGV.empty?
      puts "***********************************************
             Usage: ruby ping_script.rb 192.168.1.START END

             eg.. 192.168.1.100 200

             will scan all addresses from
             192.168.1.100 to 192.168.200
             ***********************************************"
      true
    else
      false
    end
  end

  def self.valid_input?(input)
    ip_pattern = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/
    range_pattern = /^(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
    if input[0].match(ip_pattern)
      true
    elsif input[0].match(range_pattern)
      true
    else
      puts 'Your input was not valid, did not pass valid_ipv4? function.'
      false
    end
  end

  def self.build_octet_hash(input)
    if valid_input?(input)
      octets = input[0].split('.').map(&:to_i)
      octet_hash = {
        octet1: octets[0],
        octet2: octets[1],
        octet3: octets[2],
        octet4: octets[3]
      }
      octet_hash
    else
      puts 'failed to build octet_hash'
    end
  end

  def self.ping_successful?(ping_output)
    ping_output.include?('1 packets transmitted, 1 packets received,')
  end

  def self.display_successful_pings(successful_ping_addresses)
    if !successful_ping_addresses.empty?
      puts "
        successful pings
        "
      successful_ping_addresses.each do |msg|
        puts "          #{msg}"
      end
    else
      puts 'no successful pings'
    end
  end
end

## CALL TO SCAN
input = ARGV
if input
  IpScan.scan(input)
end
