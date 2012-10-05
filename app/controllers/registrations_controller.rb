class RegistrationsController < Devise::RegistrationsController

  def new
    @suppliers = Supplier.all
    super
  end

  def create
    @user = User.new(params[:user])
    @suppliers = Supplier.all

    if @user.save
      flash[:notice] = "You have signed up successfully."
      respond_with resource, :location => after_sign_up_path_for(resource)
    else
      render :action => :new
    end
  end
end
