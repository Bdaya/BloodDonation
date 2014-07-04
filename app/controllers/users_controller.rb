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

    if @user.last_donated != nil
      @donation_date_txt = @user.last_donated.strftime("%Y-%m-%d")
    else
      @donation_date_txt = "You Haven't Donated Yet"
    end

    @user.no_of_trophies = @user.no_of_donates/2
    if @user.no_of_trophies == 0
      @trophies_txt = "You Have NOT Started Yet :)"
    else
      @trophies_txt = "Great, You Have #{@user.no_of_trophies} Trophies."
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

def confirm
 @user = User.find(params[:id])
    @request=Request.find(params[:request_id])
    @reply= Reply.find(params[:reply_id])
    if(@request.blood_bags==@reply.number_of_confirmed_users)
    @request.state="confirmed"
    @reply.is_confirmed="true"
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
        format.html { redirect_to @user, notice: 'Donor was successfully updated.' }
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

  def change_availability
    @user = User.find(params[:id])

    if @user.is_available == true
      @user.is_available = false
    else
      @user.is_available = true
    end

    if @user.save
      redirect_to @user
    end
  end

  def my_requests
    @user = User.find(params[:id])
    @all_requests = Request.all

    #  a user can donate once every 3 months (90 days)
    if @user.last_donated != nil
      time = ((Time.now - @user.last_donated)/(60*60*24)).to_i
      if (time > 90)
        @user.can_donate = true
      else
        render(:text => "You cannot Donate now, You have #{90 - time} days left so you can donate OR You will Die :D")
      end
    end

    @requests = []
    @all_requests.each do |r|
      if (@user.is_available && @user.can_donate && (r.blood_type == @user.blood_type))
        @requests.push(r)
      end
    end
  end


  def my_replies
    @user = User.find(params[:id])
    @replies = Reply.all.where(user: @user)
  end

def reply_on_request

    @user = User.find(params[:id])
    @request=Request.find(params[:request_id])
    @reply = Reply.new
    @reply.user = @user
    @reply.request = @request
    @reply.is_confirmed = true
    @reply.save

    if (@reply.save)
    @request.number_of_replies+=1
    @request.state = "pending"
    @request.reply_is_confirmed = true
    @request.save
    @user.can_donate = false
    @user.last_donated = @reply.created_at
    @user.no_of_donates += 1
    @user.save
     redirect_to @user, :notice => "Request is confirmed"
    end
  end

 def home

 end

end
