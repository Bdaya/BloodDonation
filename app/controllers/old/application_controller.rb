class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource_or_scope)
   @member
  end

  def current_request
    unless current_user
      request = Request.find(session[:current_request_id])
      if request
        return request
      else
        false
      end
    else
      false
    end
  end

end
