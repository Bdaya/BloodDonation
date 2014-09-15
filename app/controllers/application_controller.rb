class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    I18n.locale = :ar
  end

  def after_sign_in_path_for(user)
   user_path(user)
  end

  def current_request
    unless current_user
      request = Request.find(session[:current_request_id])
      if ( request && (request.national_id == session[:national_id]) )
        return request
      else
        session[:current_request_id] = nil
        session[:national_id] = nil
        false
      end
    else
      false
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit! }
    end

    # def user_params
    #   params.permit!
    #   # require(:user).permit(:name, :gender, :age, :phone)
    # end

    # def location_params
    #   params.permit!
    #   # require(:location).permit(:coordinates, :country, :city, :province, :address)
    # end

    # def request_params
    #   params.permit!
    #   # require(:request).permit(:patient_name, :contact_name, :contact_phone, :national_id, :due_date, :blood_bags, :email, :hospital_name, :hospital_phone)
    # end

end
