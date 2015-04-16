# encoding: utf-8
class RequestsController < ApplicationController
  before_action :authenticate_logging_in, only: [:edit, :update, :reopen, :update_location, :stop]
  before_action(:except => [:index, :new, :create]) { |c| c.prepare_request(params[:id]) }
  before_action :authenticate_user!, only: [:reply]
  before_action(:only => [:update, :pause, :update_last_donated, :update_location, :stop]) { |c| c.require_authority(params[:id]) }

  def index
    if current_user
      #@requests = current_user.find_matching_requests_arround
      @requests = Request.all
    else
      @requests = Request.all
    end

  end

  def show
    blood_type = @request.blood_type
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
    this_coordinates = [params[:request][:latitude], params[:request][:longitude]]
    @location = @request.location.try(:full_address) || Location.new
    @location.coordinates = this_coordinates
    @location.country = params[:country] if params[:country]
    @location.city = params[:city] if params[:city]
    @location.province = params[:province] if params[:province]
    @location.address = params[:address]
    @request.location = @location
    @location.save
    @request.blood_type = BloodType.find_by(type: params[:request][:blood_type]) if params[:request][:blood_type]
    if current_user
      @request.user = current_user
      @request.national_id = current_user.national_id
    end
    if @request.save
      @request.update request_no: Request.count
      redirect_to @request
    else
      flash[:notice] = @request.errors.full_messages
      flash[:alert] = "الرجاء ادخال بيانات صحيحة"
      render 'new'

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
      national_id = params[:request][:national_id]
      if national_id
        if @request.authenticate(national_id)
          session[:current_request_id] = @request.id
          session[:national_id] = national_id
          redirect_to @request, notice: "Successfully logged-in."
        else
          redirect_to log_in_request_path(@request), alert: "Wrong national ID! Please try again"
        end
      else
        redirect_to log_in_request_path(@request), alert: "You must enter a valid national ID!"
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
      @request = Request.find(args)
      unless @request
        redirect_to root_path, alert: "Something went wrong!"
      end
    end
end
