class TeamAthlete < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :team
  belongs_to :athlete, :class_name => "User"

  ## Attributes ##
  attr_accessible :team_id, :athlete_id, :team, :athlete, :athlete_email

  ## Validations ##
  validates :team, presence: true
  validates :athlete, presence: true

  before_validation :set_athlete
  attr_writer :athlete_email
  def athlete_email
    return self.athlete.email if self.athlete
    @athlete_email
  end

  protected

    def set_athlete
      return if self.athlete
      athlete = User.find_or_invite_by_email(@athlete_email)
      self.athlete_id = athlete.id
    end
end
