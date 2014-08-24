class UserMailer < ActionMailer::Base
  default from: "faselty.test@gmail.com"

  def new_request_email(user, request)
    @user = user
    @request_url = request_url(request)
    mail(to: @user.email, subject: 'Donation Chance!')
  end

end
