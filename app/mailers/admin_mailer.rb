class AdminMailer < ApplicationMailer
  default from: "noreply@uplay.com"
  default to: "admin@uplay.com"

  def validation_requested_email(user)
    @user = user
    mail subject: "Someone has requested a validation on his profile"
  end
end
