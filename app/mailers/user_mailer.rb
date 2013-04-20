class UserMailer < ApplicationMailer
  default from: "noreply@uplay.com"

  def invitation_email(user)
    send_mail user, "You've been invited to Trofeu to Reitor"
  end

  def added_to_team_email(user, team)
    @team = team
    send_mail(user, "Trofeu Reitor 2013 - Inscrição na equipa #{@team.name}")
  end

  def promoted_to_manager_email(user, team)
    @team = team
    send_mail(user, "Troféu Reitor 2013 - Manager da equipa #{@team.name}")
  end

  def validated_email(user)
    send_mail user, "Troféu Reitor 2013 - Dados validados"
  end

  def invalidated_email(user, msg = "Dados inválidos")
    @msg = msg
    send_mail user, "Troféu Reitor 2013 - Dados invalidados"
  end

  protected

    def send_mail(user, subject)
      @user = user
      mail to: @user.email, subject: subject
    end
end
