class RequestsController < ApplicationController
  before_action :authenticate_logging_in, only: [:edit, :update, :reopen, :update_location, :stop]
  before_action(:except => [:index, :new, :create]) { |c| c.prepare_request(params[:id]) }
  before_action :authenicate_user!, only: [:reply]
  before_action(:only => [:update, :pause, :update_last_donated, :update_location, :stop]) { |c| c.require_authority(params[:id]) }
  
  def index
    if current_user
      @requests = current_user.find_matching_requests_arround
    else
      @requests = Request.all
    end 
  end

  def show
  end

  def edit
  end

  def update
    @request.update_attributes(params[:request].permit!)
    redirect_to @request, notice: "Successfully updated your request"
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(params[:request].permit!)
    location = Location.create(params[:location].permit!)
    @request.location = location
    @request.blood_type = BloodType.find(params[:blood_type]) if params[:blood_type]
    if current_user
      @request.user = current_user
      @request.national_id = current_user.national_id
    end
    if @request.save
      redirect_to @request
    else
      redirect_to root_url, alert: "Something went wrong"
    end
  end

  def replies
    @replies = @request.replies
  end

  def reopen
    if @request.reopen
      redirect_to @request, notice: "Successfully republished the request."
    else
      redirect_to root_url, alert: "Something went wrong"
    end
  end

  def log_in
    if user_signed_in?
      redirect_to @request, alert: "Your are already signed in!"
    end
  end

  def authenticate
    if user_signed_in?
      redirect_to @request, alert: "Your are already signed in!"
    else
      national_id = params[:national_id]
      if national_id
        if @request.authenticate(national_id)
          session[:current_request_id] = @request.id
          session[:national_id] = national_id
          redirect_to @request, notice: "Successfully logged-in."
        else
          redirect_to log_in_requests_path(@request), alert: "Wrong national ID! Please try again"
        end
      else
        redirect_to log_in_requests_path(@request), alert: "You must enter a valid national ID!"
      end
    end
  end

  def update_location
    if @request.location.update_attributes(params[:location].permit!)
      redirect_to @request, notice: "Successfully updated your current location."
    else
      redirect_to @request, alert: "Something went wrong!"
    end
  end

  def stop
    if @request.stop
      redirect_to root_url, notice: "Successfully cancelled the request."
    else
      redirect_to root_url, alert: "Something went wrong"
    end
  end

  def reply
    if (@request.blood_type == current_user.blood_type)
      @reply = Reply.new(request: @request, user: current_user)
      if @reply.save
        redirect_to @request, notice: "Congrats! you successfully responded to the request..\n He should be waiting for you there."
      else
        redirect_to @request, alert: "Something went wrong"
      end
    else
      redirect_to root_url, alert: "The request's blood type doesn't match yours!"
    end
  end

  # private
    def authenticate_logging_in
      unless user_signed_in? || current_request
        redirect_to root_path, alert: "You must log-in first!"
      end
    end

    def require_authority(args)
      unless (current_user && (@request.user == current_user) ) || (current_request && (current_request == @request))
        redirect_to root_path, alert: "You can only edit this for your account."
      end
    end

    def prepare_request(args)
      @request = Request.find_by(id: args)
      unless @request
        redirect_to root_path, alert: "Something went wrong!"
      end
    end
end
