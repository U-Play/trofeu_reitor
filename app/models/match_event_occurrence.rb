class MatchEventOccurrence < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :match_event
  belongs_to :match
  belongs_to :athlete, :class_name => "User"

  ## Attributes ##
  attr_accessible :deleted_at, :time, :total, :match_event, :match, :athlete

  ## Validations ##
  validates [:match_event, :match, :athlete], presence: true
end
