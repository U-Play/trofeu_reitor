class UserMailer < ApplicationMailer
  default from: "tr2013@uplaypro.com"

  def invitation(user)
    send_mail user, "You've been invited to Trofeu to Reitor"
  end

  def added_to_team(user, team)
    @team = team
    send_mail(user, "Trofeu Reitor 2013 - Inscrição na equipa #{@team.name}")
  end

  def promoted_to_manager(user, team)
    @team = team
    send_mail(user, "Troféu Reitor 2013 - Manager da equipa #{@team.name}")
  end

  def validated(user)
    send_mail user, "Troféu Reitor 2013 - Dados validados"
  end

  def invalidated(user, msg = "Dados inválidos")
    @msg = msg
    send_mail user, "Troféu Reitor 2013 - Dados invalidados"
  end

  protected

  def send_mail(user, subject)
    @user = user
    @subject = subject
    mail to: @user.email, subject: @subject
  end

  def credentials_ready(user, file)
    @user = user
    @file = file
    mail to: @user.email, subject: "Your credentials are ready"
  end
end
