class TeamAthlete < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :team
  belongs_to :athlete, :class_name => "User"

  ## Attributes ##
  attr_accessible :team_id, :athlete_id, :team, :athlete, :athlete_email

  attr_writer :athlete_email

  ## Validations ##
  validates :team, :athlete, presence: true
  validate :athletes_per_team, :on => :create

  ## Callbacks ##
  before_validation :set_athlete
  after_create :send_email

  ## Public Methods ##
  def athlete_email
    return self.athlete.email if self.athlete
    @athlete_email
  end

  ## Private Methods ##
  protected

    def athletes_per_team
      if ( (TeamAthlete.where(:team_id => team_id).count + 1) > team.athletes_per_team )
        errors.add( :athletes, ": too many for this #{team.sport_type} sport" ) 
      end
    end

    def set_athlete
      return if self.athlete
      athlete = User.find_or_invite_by_email(@athlete_email)
      self.athlete_id = athlete.id
    end

    def send_email
      UserMailer.added_to_team(self.athlete, self.team).deliver
    end
end
