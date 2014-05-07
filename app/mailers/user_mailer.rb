class UserMailer < ActionMailer::Base
  default from: "alexhawkins.me@gmail.com"

  def welcome_email(user)
    @user = user
    @url = 'http://yummymark.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to YummyMarks')
  end

end
