class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(user_params)
    blood_type = BloodType.find(params[:blood_type])
    this_coordinates = [params[:latitude], params[:longitude]]
    location = Location.create(coordinates: this_coordinates, country: params[:country], city: params[:city], province: params[:province], address: params[:address])
    @user.blood_type = blood_type
    @user.location = location
    if @user.save
        redirect_to root_url, notice: "Congrats! You successfully registered!"
    else
        redirect_to new_user_registration_path, alert: "Please complete all data correctly!"
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

end
