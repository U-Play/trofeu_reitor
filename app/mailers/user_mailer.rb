class UserMailer < ActionMailer::Base
  default from: "noreply@uplay.com"

  def invitation_email(user)
    @user = user
    mail to: user.email, subject: "You've been invited to Trofeu do Reitor"
  end
end
