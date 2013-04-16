class UserMailer < ActionMailer::Base
  default from: "noreply@uplay.com"

  def invitation_email(user)
    send_mail user, "You've been invited to Trofeu to Reitor"
  end

  def promoted_to_manager_email(user, team)
    @team = team
    send_mail(user, "You've been promoted to manager of #{@team.name}")
  end

  def validated_email(user)
    send_mail user, "Your data has been validated"
  end

  def invalidated_email(user)
    send_mail user, "There's something wrong with your validation"
  end

  protected

    def send_mail(user, subject)
      @user = user
      mail to: email, subject: subject
    end
end
