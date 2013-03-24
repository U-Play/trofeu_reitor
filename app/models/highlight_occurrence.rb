class HighlightOccurrence < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :highlight
  belongs_to :match
  belongs_to :athlete, :class_name => "User"

  ## Attributes ##
  attr_accessible :deleted_at, :time, :total, :highlight, :match, :athlete

  ## Validations ##
  validates [:highlight, :match, :athlete], presence: true
end
