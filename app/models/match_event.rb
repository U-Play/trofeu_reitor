class MatchEvent < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :sport

  has_many :match_event_occurrences
  has_many :athletes, :through => :match_event_occurrences, :source => :user
  has_many :matches, :through => :match_event_occurrences

  ## Attributes ##
  attr_accessible :deleted_at, :description, :name

  ## Validations ##
  validates :sport_id, presence: true

end
