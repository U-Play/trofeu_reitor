class MatchAthlete < ActiveRecord::Base

  ## Relations ##
  belongs_to :match
  belongs_to :team
  belongs_to :athlete, class_name: "User"

  ## Attributes ##
  attr_accessible :starter, :substitute, :number, :captain, :match, :team, :athlete

  ## Validations ##
  validates :match, :team, :athlete, :presence => true
end
