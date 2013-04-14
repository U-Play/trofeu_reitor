class UserMailer < ActionMailer::Base
  default from: "noreply@uplay.com"

  def invitation_email(user)
    @user = user
    mail to: user.email, subject: "You've been invited to Trofeu do Reitor"
  end

  def promoted_to_manager_email(user, team)
    @user = user
    @team = team
    mail to: @user.email, subject: "You've been promoted to manager of #{@team.name}"
  end
end
