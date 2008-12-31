class ResolveController < ApplicationController
	layout 'standard'
  def resolve
	require 'ping'
	require 'resolv'
	@ip = Ip.find(params[:id])

	dns = Resolv::DNS.new 

	#Copy from IP Table to IP_HISTORIAN Table
	@ip_historian = IpHistorian.create(@ip.attributes)

	begin #Get PTR_REC
	  @ip.ptr_rec = dns.getname(@ip.ip_address).to_s
	  #Strip the domain off the hostname
	  @ip.ptr_rec = @ip.ptr_rec.sub(/\..*/, "")
	rescue StandardError
	  @ip.ptr_rec = nil
	end

	begin #Get A_REC
	  @ip.a_rec = dns.getaddress(@ip.hostname).to_s
	rescue StandardError
	  @ip.a_rec = nil
	end

	@ip.pingable = Ping.pingecho(@ip.ip_address, 2) 

	@ip.update_attributes(nil)
  end

  def resolve_all
	require 'ping'
	require 'resolv'
	@ip_to_resolve = Ip.find(:all)

	
	@ip_to_resolve.each{ |resolved| 
		#Copy from IP Table to IP_HISTORIAN Table
		#@ip_historian = IpHistorian.create(x.attributes)

		dns = Resolv::DNS.new 
		begin #Get PTR_REC
		  resolved.ptr_rec = dns.getname(resolved.ip_address).to_s
		  #Strip the domain off the hostname
		  resolved.ptr_rec = resolved.ptr_rec.sub(/\..*/, "")
		rescue StandardError
		  resolved.ptr_rec = nil
		end

		dns = Resolv::DNS.new 
		begin #Get A_REC
		  resolved.a_rec = dns.getaddress(resolved.hostname).to_s
		rescue StandardError
		  resolved.a_rec = nil
		end

		resolved.pingable = Ping.pingecho(resolved.ip_address, 2) 

		#find last state object by ip address

		#@last_state = Ip.find(:first, :conditions => "ip_address = 'resolved.ip_address.to_s'" )
		@last_state = Ip.first(:conditions => { :ip_address => resolved.ip_address })
		#compare the detected with the current value of ip for same ip
		
		if @last_state.a_rec != resolved.a_rec or @last_state.ptr_rec != resolved.ptr_rec or @last_state.pingable != resolved.pingable
			#Only copy the IP Table to IP_HISTORIAN table if detected =! historian
			IpHistorian.create(resolved.attributes)
		end

		#update the ip table regaurdless
		resolved.update_attributes(nil)

	}
  end

end
