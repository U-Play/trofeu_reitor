class Sport < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  has_many :highlights, :dependent => :destroy
  has_many :tournaments

  ## Attributes ##
  attr_accessible :name, :description, :athletes_per_team, :highlights_attributes

  accepts_nested_attributes_for :highlights, :allow_destroy => true

  ## Validations ##
  validate :name, :athletes_per_team, presence: true

  ## Public Methods ##
  def is_individual?
    athletes_per_team == 1
  end

  def is_team?
    athletes_per_team > 1
  end
end
