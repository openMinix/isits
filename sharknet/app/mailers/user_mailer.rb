class UserMailer < ActionMailer::Base
  default from: "isitscompany@gmail.com"

  def rejected_email( user )
    @user = user
    mail( to: @user.email, subject:"Rejected timesheet" )
  end

  def notify_email( user )
    @user = user
    mail( to: @user.email, subject:"Timesheet received" )
  end

end
