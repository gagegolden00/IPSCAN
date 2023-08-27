#!/bin/env ruby
def get_my_ips
    public_ip = `curl ifconfig.me`
    private_ip = `hostname -I | cut -d' ' -f1`
    puts "
        Public IP Address: #{public_ip}
        Private IP Address: #{private_ip}
    "
end
get_my_ips
