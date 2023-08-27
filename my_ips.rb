def extract_ip_addresses(output)
    ip_addresses = []

    lines = output.split("\n")
    current_label = nil

    lines.each do |line|
      if line =~ /^([\w\d]+):\s/
        current_label = $1
      elsif line =~ /\binet (\d+\.\d+\.\d+\.\d+)/
        ip_addresses << [current_label, $1]
      end
    end

    ip_addresses
  end

  def get_my_ips
    public_ip = `curl ifconfig.me`.strip
    puts "Public IP Address: #{public_ip}"
  end

  ifconfig_output = `ifconfig`
  ip_addresses = extract_ip_addresses(ifconfig_output)

  ip_addresses.each do |(label, ip)|
    puts "Label: #{label}, IP: #{ip}" if ip
  end

  get_my_ips
