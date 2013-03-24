class MatchReferee < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :match
  belongs_to :user

  ## Attributes ##
  attr_accessible :deleted_at, :match, :user

  ## Validations ##
  validates :match, presence: true
  validates :user, presence: true

end
