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
  validates :athlete_id, :uniqueness_without_deleted => { :scope => :team_id }
  validate  :athlete_uniqueness_per_tournament, :on => :create
  validate  :athlete_count_per_team, :on => :create

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

    def athlete_count_per_team
      if ( (TeamAthlete.where(:team_id => team_id).count + 1) > team.athletes_per_team )
        errors.add( :athletes, "too many for this sport" ) 
      end
    end

    def athlete_uniqueness_per_tournament
      if ( TeamAthlete.where( :team_id => Team.where( :tournament_id => self.team.tournament_id ), :athlete_id => self.athlete_id ).any? )
        errors.add( :athlete, "already belongs to a team in this tournament" ) 
      end
    end

    def set_athlete
      return if self.athlete
      athlete = User.find_or_invite_by_email(@athlete_email)
      if !athlete.course.nil?
        if athlete.course.id != self.team.course.id
          errors.add( :athlete, "course doesn't match the team's course" ) 
        end
      else
        athlete.update_attributes course: self.team.course
      end
      self.athlete_id = athlete.id
    end

    def send_email
      UserMailer.added_to_team(self.athlete, self.team).deliver
    end
end
