class TeamReferee < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :team
  belongs_to :referee, :class_name => "User"

  ## Attributes ##
  attr_accessible :team, :referee, :team_id, :referee_id

  ## Validations ##
  validates :team, presence: true
  validates :referee, presence: true

end
