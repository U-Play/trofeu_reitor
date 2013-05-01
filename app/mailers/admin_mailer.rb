class AdminMailer < ApplicationMailer
  default from: "noreply@uplay.com"
  default to: "vtr@uplaypro.com" # TODO definir aqui o mail do admin

  def validation_requested(user)
    @user = user
    @subject = "Troféu Reitor 2013 - Validação de Atleta"
    #mail to: User.by_role('admin').map(&:email), subject: "Troféu Reitor 2013 - Validação de Atleta"
    mail subject: @subject
  end
end
