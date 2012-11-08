class RegistrationsController < Devise::RegistrationsController

  def new
    @purchase = Purchase.new
    super
  end

  def create
    build_resource
    resource.valid?
    @purchase = Purchase.new(params[:purchase])
    @purchase.ip_address = request.remote_ip
    if @purchase.save
      if @purchase.purchase
        @admin = Admin.new(params[:admin])
        @admin.purchase = @purchase
        @admin.save
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def update
    super
  end

end 
