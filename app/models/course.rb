class Course < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  has_many :athletes, class_name: 'User'

  ## Attributes ##
  attr_accessible :name

  ## Validations ##
  validates :name, presence: true 
end
