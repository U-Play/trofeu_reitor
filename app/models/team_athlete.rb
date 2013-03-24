class TeamAthlete < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :team
  belongs_to :user

  ## Attributes ##
  attr_accessible :deleted_at, :team_id, :user_id, :team, :user

  ## Validations ##
  validates :team, presence: true
  validates :user, presence: true

end
