class UserMailer < ActionMailer::Base
  default from: "isitscompany@gmail.com"

  def info_email( user )
    @user = user
    mail( to: @user.email, subject:"Test email" )
  end
end
