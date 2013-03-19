class Match < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament
  belongs_to :local
  belongs_to :winner, :class_name => "Team"
  belongs_to :team_one, :class_name => "Team"
  belongs_to :team_two, :class_name => "Team"

  has_many :news
  has_many :penalties

  has_many :match_referees, :inverse_of => :match
  has_many :referees, :through => :match_referees, :source => :user

  has_many :match_event_occurrences
  has_many :athletes, :through => :match_event_occurrences, :source => :user
  has_many :match_events, :through => :match_event_occurrences

  ## Attributes ##
  attr_accessible :deleted_at, :end_date, :group, :position, :start_date

  ## Validations ##
  validates :tournament_id, presence: true
  validates :local_id, presence: true
end
