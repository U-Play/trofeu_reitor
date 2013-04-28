class TeamData < ActiveRecord::Base

  ## Relations ##
  belongs_to :match
  belongs_to :team

  ## Attributes ##
  attr_accessible :color, :result, :match, :team

  ## Validations ##
  validates :match, :team, :presence => true

end
