class MatchEventOccurrence < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :match_event
  belongs_to :match
  belongs_to :user

  ## Attributes ##
  attr_accessible :deleted_at, :time, :total, :match_event, :match, :user

  ## Validations ##
  validates [:match_event, :match, :user], presence: true
end
