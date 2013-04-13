class Location < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  has_many :matches

  ## Attributes ##
  attr_accessible :city

  ## Validations ##
end
