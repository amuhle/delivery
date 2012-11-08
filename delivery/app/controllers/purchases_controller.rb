class PurchasesController < ApplicationController

  def new 
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(params[:purchase])
    @purchase.ip_address = request.remote_ip
    if @purchase.save
      if @purchase.purchase
        redirect_to :controller => '/devise/registrations', :action => "new", :format => 'html'
      else
        render :action => "new"
      end
    else
      render :action => 'new'
    end
  end

end
