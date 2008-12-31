class IpHistorianController < ApplicationController
	layout 'standard'
	
	def show
		@ip = Ip.find(params[:id])
		@ip_historians = IpHistorian.find(:all, :conditions => [ "ip_address = ? OR hostname = ? OR a_rec = ? OR ptr_rec = ?", @ip.ip_address, @ip.hostname, @ip.a_rec, @ip.ptr_rec])
	end
	
end
