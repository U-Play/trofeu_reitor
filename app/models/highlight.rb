class Highlight < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :sport

  has_many :highlight_occurrences
  has_many :athletes, :through => :highlight_occurrences, :source => :user
  has_many :matches, :through => :highlight_occurrences

  ## Attributes ##
  attr_accessible :description, :name, :sport_id

  ## Validations ##
  validates :sport_id, :name, presence: true

end
