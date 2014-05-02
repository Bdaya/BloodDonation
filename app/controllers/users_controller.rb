class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    @user.no_of_trophies = @user.no_of_donates/2
    if @user.no_of_trophies == 0
      @trophies_txt = "You Have NOT Started Yet :)"
    else
      @trophies_txt = "Great, You Have #{@user.no_of_trophies} Trophies."
    end


  

  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Donor was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def my_requests
    @user = User.find(params[:id])
    @requests = Request.all

    if (@user.is_available && @user.can_donate) 
      @requests = Request.where(blood_type: @user.blood_type)
       
    end
  end

def reply_on_request
    @user = User.find(params[:id])
    @request=Request.find([:request_id])
    @reply = Reply.new
    reply.user = @user
    reply.request = @request
    @reply.save
    
    if @reply.save
     redirect_to @user, :notice => "Request is confirmed"
    end
 end   
 def home 
 end
end
