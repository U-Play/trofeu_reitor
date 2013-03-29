class TeamReferee < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :team
  belongs_to :user

  ## Attributes ##
  attr_accessible :team, :user

  ## Validations ##
  validates :team, presence: true
  validates :user, presence: true

end
