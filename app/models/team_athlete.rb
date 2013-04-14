class TeamAthlete < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :team
  belongs_to :athlete, :class_name => "User"

  ## Attributes ##
  attr_accessible :team_id, :athlete_id, :team, :athlete

  ## Validations ##
  validates :team, presence: true
  validates :athlete, presence: true

end
