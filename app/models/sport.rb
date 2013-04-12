class Sport < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  has_many :highlights, :dependent => :destroy
  has_many :tournaments

  ## Attributes ##
  attr_accessible :name, :description, :highlights_attributes

  accepts_nested_attributes_for :highlights, :allow_destroy => true
end
