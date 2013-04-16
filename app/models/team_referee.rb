class TeamReferee < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :team
  belongs_to :referee, :class_name => "User"

  ## Attributes ##
  attr_accessible :team, :referee, :team_id, :referee_id, :referee_email

  ## Validations ##
  validates :team, presence: true
  validates :referee, presence: true

  before_validation :set_referee
  attr_writer :referee_email
  def referee_email
    return self.referee.email if self.referee
    @referee_email
  end

  protected

    def set_referee
      return if self.referee
      referee = User.find_or_invite_by_email(@referee_email)
      self.referee_id = referee.id
    end

end
