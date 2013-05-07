class Course < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  has_many :athletes, class_name: 'User'

  ## Attributes ##
  attr_accessible :name, :abbreviation

  ## Validations ##
  validates :name, presence: true 

  ## Methods ##
  def to_s
    name
  end
end
