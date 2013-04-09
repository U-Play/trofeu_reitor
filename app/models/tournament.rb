class Tournament < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :sport
  belongs_to :format
  belongs_to :event

  has_one :group_stage, :inverse_of => :tournament
  has_one :knockout_stage, :inverse_of => :tournament

  has_many :teams, :order => 'id'
  has_many :matches, :order => 'id'
  # has_many :news

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  ## Nested Attributes ##
  accepts_nested_attributes_for :group_stage
  #Check careful this because when we select group_stage, knockout_stage is still created
  accepts_nested_attributes_for :knockout_stage

  ## Attributes ##
  attr_accessible :contacts, :description, :end_date, :name, :number_of_teams, :rules, :start_date,
    :event_id, :sport_id, :format_id, :group_stage_attributes, :knockout_stage_attributes

  ## Validations ##
  validates :sport, presence: true
  validates :event, presence: true
  validates :name, presence: true
  validates :number_of_teams, :numericality => {:only_integer => true, :greater_than => 1}
  validates :format, presence: true

  ## Callbacks ##
  before_validation :set_event
  before_save :reject_format

  ##Public Methods##

  def draft_made?
    number_games = (2 ** self.number_of_stages)/2
    games_drafted = 0
    self.matches.each do |m|
      games_drafted += 1 unless (m.team_one.nil? && m.team_two.nil?) || m.position > number_games
    end
    return number_games == games_drafted 
  end

  def create_teams
    i = 1
    self.number_of_teams.times do
      self.teams.create name: "Team " << i.to_s 
      i += 1      
    end
  end

  def create_knockout_matches
    number_of_stages = self.number_of_stages
    if self.knockout_stage.nil? || !self.knockout_stage.third_place?
      number_of_games = (2 ** number_of_stages) - 1
    else
      number_of_games = 2 ** number_of_stages 
    end
    i = 1
    #Create all Games
    number_of_games.times do
      self.matches.create position: i
      i += 1
    end
  end

  def number_of_stages
    for number_of_stages in 0..self.number_of_teams
      if self.number_of_teams <= 2 ** number_of_stages
        break
      end
    end
    puts "The number of stages needed are " << number_of_stages.to_s
    number_of_stages
  end

  protected

  def set_event
    self.event ||= Event.first
  end

  def reject_format
    if self.format_id == 1
      self.knockout_stage = nil
    elsif self.format_id == 2
      self.group_stage = nil
    end
  end
end
