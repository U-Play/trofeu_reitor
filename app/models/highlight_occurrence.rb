class HighlightOccurrence < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :highlight
  belongs_to :match
  belongs_to :athlete, :class_name => "User"

  ## Attributes ##
  attr_accessible :time, :highlight, :match, :athlete, :highlight_id, :match_id, :athlete_id

  ## Validations ##
  validates :highlight, :match, :athlete, :time, presence: true
end
