class UserMailer < ActionMailer::Base
  default from: "faselty.test@gmail.com"

  def new_request_email(user, request)
    @user = user
    @request_url = request_url(request)
    mail(to: @user.email, subject: 'Donation Chance!')
  end

  def new_reply_email(user, request)
    @request = request
    @user = user
    @user_url = user_url(@user)
    mail(to: @request.email, subject: 'Donor Comming!')
  end

end
