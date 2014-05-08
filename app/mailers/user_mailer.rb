class UserMailer < ActionMailer::Base
  default from: "alexhawkins.me@gmail.com"

  def welcome_email(user, bookmark_title, bookmark_url)
    @user = user
    @bookmark_title = bookmark_title
    @bookmark_url = bookmark_url
    @url = 'http://yummymark.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to YummyMarks')
  end

  def bookmark_created_email(user, bookmark)
    @user = user
    @bookmark = bookmark
    @url = 'http://yummymark.herokuapp.com' + edit_bookmark_path(@bookmark)
    mail(to: @user.email, subject:  'NEW BOOKMARK: ' + @bookmark.title)
  end

end




