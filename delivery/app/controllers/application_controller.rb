class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User)
        orders_patht()
      else
        users_path()
      end
  end

  def after_sign_out_path_for(resource_or_scope)
    respond_to?(:root_path) ? root_path : "/"
  end

end
