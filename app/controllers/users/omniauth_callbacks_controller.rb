class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_filter :prepare_auth

  def linkedin
    connect(:linkedin)
  end


  def facebook
    connect(:facebook)
  end

  def angellist
    connect(:angellist)
  end

  def twitter
    connect(:twitter)
  end

  def google_oauth2
    connect(:google)
  end

  private

    def prepare_auth
      @auth = request.env["omniauth.auth"]
    end

    def connect(provider_type)
      social_provider = SocialProvider.find_for_oauth(@auth, provider_type)
      if user_signed_in?
        if social_provider and social_provider.user_id == current_user.id
          flash[:notice] = "Your #{provider_type} account is already attached"
          redirect_to current_user and return
        elsif social_provider.user_id.nil?
          current_user.update_from_oauth(@auth, provider_type)
          current_user.social_providers << social_provider if current_user.save
          flash[:notice] = "Successfully attached #{provider_type} account"
          redirect_to current_user and return
        else
          flash[:notice] = "#{provider_type} is already connected to another account"
          redirect_to current_user and return
        end
      else
        @user = social_provider.user || User.find_by(email: @auth[:info][:email]) || User.new
        @user.update_from_oauth(@auth, provider_type)
        social_provider.save
        if @user.persisted? # If user already has account and not logged in
          @user.social_providers << social_provider if @user.save
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider_type.capitalize
          sign_in_and_redirect @user, :event => :authentication
        else # If user has no account
          session[:sp_id] = social_provider.id 
          redirect_to new_user_registration_path
        end
      end
    end
end

