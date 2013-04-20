class AdminMailer < ApplicationMailer
  default from: "noreply@uplay.com"
  #default to: "admin@uplay.com" # TODO definir aqui o mail do admin

  def validation_requested_email(user)
    @user = user
    mail to: "mpalhas@gmail.com", subject: "Someone has requested a validation on his profile"
  end
end
