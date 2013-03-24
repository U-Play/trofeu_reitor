class Match < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament
  belongs_to :location
  belongs_to :winner, :class_name => "Team"
  belongs_to :team_one, :class_name => "Team"
  belongs_to :team_two, :class_name => "Team"

  has_many :penalties
  # has_many :news

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  has_many :match_referees, :inverse_of => :match
  has_many :referees, :through => :match_referees, :source => :user

  has_many :highlight_occurrences
  has_many :athletes, :through => :highlight_occurrences, :source => :user
  has_many :highlights, :through => :highlight_occurrences

  ## Attributes ##
  attr_accessible :end_date, :group, :position, :start_date

  ## Validations ##
  validates :tournament_id, presence: true
  validates :location_id, presence: true
end
