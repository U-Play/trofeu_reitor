class Sport < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  has_many :match_events
  has_many :tournaments

  ## Attributes ##
  attr_accessible :name
end
