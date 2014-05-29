class ContentController < ActionController::Base
  layout 'application'
  def index
  end

  def about
    @users = User.all
    respond_to do |format|
      format.html # about.html.erb
      format.json { render json: @user }
    end
  end

  def donator_info
  end

  def donation_info
  end

  def blood_info
  end

  def patient_info
  end

  def news
  end

  def contact
  end
end
