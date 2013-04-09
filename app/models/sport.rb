class Sport < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  has_many :highlights
  has_many :tournaments

  ## Attributes ##
  attr_accessible :name, :description
end
