class Format < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  has_many :tournaments

  ## Attributes ##
  attr_accessible :description, :name
end
