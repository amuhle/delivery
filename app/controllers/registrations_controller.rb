class RegistrationsController < Devise::RegistrationsController

  def new
    @purchase = Purchase.new
    @supplier = Supplier.new
    super
  end

  def create
    @admin = Admin.new(params[:admin],:supplier => params[:supplier],:purchase => params[:purchase])
    @purchase = Purchase.new(params[:purchase])
    @purchase.ip_address = request.remote_ip
    @supplier = Supplier.new(params[:supplier])
    @supplier.email = @admin.email
    if @supplier.valid? && @purchase.valid? && @admin.valid?
      @purchase.save
      if @purchase.purchase
        @supplier.save
        @admin.supplier = @supplier
        @admin.purchase = @purchase
        if @admin.save
          flash[:notice] = "You have signed up successfully."
          respond_with resource, :location => after_sign_up_path_for(resource)
        else
          render 'new'
        end
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
