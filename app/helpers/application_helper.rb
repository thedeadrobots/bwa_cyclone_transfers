

module ApplicationHelper
  
  def all_my_ipv4_interfaces
  Socket.ip_address_list.select{|intf| intf.ipv4?}
  end

  def my_loopback_ipv4
  Socket.ip_address_list.detect{|intf| intf.ipv4_loopback?}
  end

  def my_first_private_ipv4
  Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  end

  def my_first_public_ipv4
  Socket.ip_address_list.detect{|intf| intf.ipv4? and !intf.ipv4_loopback? and !intf.ipv4_multicast? and !intf.ipv4_private?}
  end
  
  def local_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end
  
end
