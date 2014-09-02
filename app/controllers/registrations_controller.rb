class RegistrationsController < Devise::RegistrationsController
  before_action(:only => [:create]) { |c| c.check_important_params(params) }
  def create
    @user = User.new(params[:user].permit!)
    blood_type = BloodType.find_by(type: params[:user][:blood_type]) unless params[:user][:blood_type].blank?

    this_coordinates = [params[:user][:latitude], params[:user][:longitude]]
    location = Location.new
    location.coordinates = this_coordinates
    location.country = params[:country] if params[:country]
    location.city = params[:city] if params[:city]
    location.province = params[:province] if params[:province]
    location.address = params[:address]
    location.save
    @user.blood_type = blood_type
    @user.location = location
    if @user.save
        redirect_to root_url, notice: "Congrats! You successfully registered!"
    else
        flash[:alert] = "الرجاء إدخال البيانات كاملة"
        render 'new'# alert: "Please complete all data correctly!"
    end
    # build_resource(sign_up_params)

    # resource_saved = resource.save
    # yield resource if block_given?
    # if resource_saved
    #   if resource.active_for_authentication?
    #     set_flash_message :notice, :signed_up if is_flashing_format?
    #     sign_up(resource_name, resource)
    #     respond_with resource, location: after_sign_up_path_for(resource)
    #   else
    #     set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
    #     expire_data_after_sign_in!
    #     respond_with resource, location: after_inactive_sign_up_path_for(resource)
    #   end
    # else
    #   clean_up_passwords resource
    #   @validatable = devise_mapping.validatable?
    #   if @validatable
    #     @minimum_password_length = resource_class.password_length.min
    #   end
    #   respond_with resource
    # end
  end
  # private
    def check_important_params(params)
      unless params[:user][:latitude] && params[:user][:longitude] && params[:user][:blood_type]
        redirect_to new_user_registration_path, alert: "Please complete all the data correctly!"
      end
    end
end
