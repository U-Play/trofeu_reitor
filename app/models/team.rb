class Team < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament
  belongs_to :coach, :class_name => "User"

  has_many :match_as_team_one, :class_name => "Match", :foreign_key => "team_one_id"
  has_many :match_as_team_two, :class_name => "Match", :foreign_key => "team_two_id"
  has_many :match_as_winner, :class_name => "Match", :foreign_key => "winner_id"
  has_many :news
  has_many :penalties

  has_many :team_athletes, :dependent => :destroy, :inverse_of => :team
  has_many :athletes, :through => :team_athletes, :source => :user

  has_many :team_referees, :inverse_of => :team
  has_many :referees, :through => :team_referees, :source => :user

  ## Attributes ##
  attr_accessible :deleted_at, :name, :tournament_id, :coach_id

  ## Validations ##
  validates :tournament_id, presence: true

  ## Nested Resources ##
  # accepts_nested_attributes_for :team_athletes, :allow_destroy => true
end
