class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_users
  before_filter :get_supplier

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User)
        orders_path()
      else
        users_path()
      end
  end

   def after_sign_out_path_for(resource_or_scope)
      respond_to?(:root_path) ? root_path : "/"
   end

  def authenticate_users
    unless user_signed_in? || admin_signed_in?
      authenticate_user! || authenticate_admin!
    end
  end

  def get_supplier
    if user_signed_in? || admin_signed_in?
        @current_suppllier = Supplier.find(current_user.supplier_id) if current_user
        @current_suppllier = Supplier.find(current_admin.supplier_id) if current_admin
    end
  end
end
