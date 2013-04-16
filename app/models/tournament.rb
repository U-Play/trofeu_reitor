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
  has_many :groups
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
  after_create :create_teams
  after_create :elaborate_format

  ## Scopes ##


  ##Public Methods##

  # According to the format of the tournament, create the necessary games
  def elaborate_format
    #Format: Multi Stage
    if self.group_stage && self.knockout_stage
      puts "NOT IMPLEMENTED"
    #Format: Group Stage
    elsif self.group_stage
      puts "NOT IMPLEMENTED"
    #Format: Knockout Stage
    elsif self.knockout_stage
      self.knockout_stage.create_knockout_matches
    end
  end

  #Immediately create the number of teams of a tournament
  def create_teams
    i = 1
    self.number_of_teams.times do
      self.teams.create name: "Team " << i.to_s 
      i += 1
    end
  end

  ## Public Methods ##
  def has_group_stage?
    #TODO check a better way to references group stage and multi stage other than the ids
    format_id == 1 or format_id == 3
  end

  def has_knockout_stage?
    #TODO check a better way to references group stage and multi stage other than the ids
    format_id == 2 or format_id == 3
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
