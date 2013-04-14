class Format < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  has_many :tournaments
  has_many :matches

  ## Attributes ##
  attr_accessible :description, :name, :deleted_at

  ## Validations ##
  validates :name, presence: true
end
