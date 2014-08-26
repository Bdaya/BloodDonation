class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:settings, :update, :pause, :update_last_donated, :update_location]
  before_action { |c| c.prepare_user(params[:id]) }
  before_action(:only => [:settings, :pause, :update_last_donated, :update_location]) { |c| c.require_user_authority(params[:id]) }

  def show
  end
  
  def settings
  end

  def update
    @user.update_attributes(user_params)
    redirect_to @user, notice: "Successfully updated your information"
  end

  def reports
    @user.reports
  end

  def donations
    @all_donations = @user.replies
    @confirmed_donations = @user.confirmed_donations
    @uncompleted_donations  = @user.uncompleted_donations
    @cancelled_donations = @user.cancelled_donations
  end

  def pause
    if @user.update_attribute(:pause, true)
      redirect_to @user, notice: "Successfully paused your donation ability."
    else
      redirect_to @user, alert: "Something went wrong!"
    end
  end

  def update_last_donated
    if @user.update_attribute(:last_donated, DateTime.now)
      redirect_to @user, notice: "Congrats on your donation! You won't receive notifications before 3 months pass..\n But you can still Browse the requests."
    else
      redirect_to @user, alert: "Something went wrong!"
    end
  end

  def update_location
    if @user.location.update_attributes(location_params)
      redirect_to @user, notice: "Successfully updated your current location."
    else
      redirect_to @user, alert: "Something went wrong!"
    end
  end

  private
    def require_user_authority(args)
      unless (current_user && (current_user == @user) )
        redirect_to root_path, alert: "You can only edit this for your account."
      end
    end

    def prepare_user(args)
      @user = User.find(args)
      unless @user
        redirect_to root_path, alert: "Something went wrong!"
      end
    end
end