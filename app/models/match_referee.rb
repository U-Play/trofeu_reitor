class MatchReferee < ActiveRecord::Base
  ## Relations ##
  belongs_to :match
  belongs_to :referee, :class_name => "User"

  ## Attributes ##
  attr_accessible :match, :referee, :match_id, :referee_id

  ## Validations ##
  validates :match, :referee, presence: true
  validates :match_id, :uniqueness => {:scope => :referee_id, :message => "Can't duplicate referees!"}

end
