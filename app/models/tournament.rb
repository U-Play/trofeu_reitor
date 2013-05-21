class Tournament < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :sport
  belongs_to :format
  belongs_to :event

  has_one :group_stage, :inverse_of => :tournament
  has_one :knockout_stage, :inverse_of => :tournament

  has_many :teams, :order => 'id'
  has_many :matches, :order => 'position'
  has_many :groups, :order => 'name'

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  ## Nested Attributes ##
  accepts_nested_attributes_for :group_stage
  accepts_nested_attributes_for :knockout_stage

  ## Attributes ##
  attr_accessible :contacts, :description, :end_date, :name, :number_of_teams, :rules, :start_date,
    :event_id, :sport_id, :format_id, :group_stage_attributes, :knockout_stage_attributes

  ## Validations ##
  validates :sport, presence: true
  validates :event, presence: true
  validates :name, presence: true

  ## Callbacks ##
  before_validation :set_event
  before_save :reject_format

  ##Public Methods##

  # According to the format of the tournament, create the necessary matches
  def elaborate_format
    #Format: Multi Stage
    if self.group_stage && self.knockout_stage
      puts "NOT IMPLEMENTED"
    #Format: Group Stage
    elsif self.group_stage
      self.group_stage.create_groups
    #Format: Knockout Stage
    elsif self.knockout_stage
      self.knockout_stage.create_knockout_matches
    end
  end

  def has_minimum_teams?
    self.teams.size >= 2
  end

  def began?
    !self.number_of_teams.nil?
  end

  def has_group_stage?
    format_id == Format.group_format.id or format_id == Format.multi_stage_format.id
  end

  def has_knockout_stage?
    format_id == Format.knockout_format.id or format_id == Format.multi_stage_format.id
  end

  def all_groups_with_min_teams?
    self.groups.all?{ |g| g.teams.size >= 2 }
  end

  def all_teams_in_groups?
    self.number_of_teams == self.teams.where('group_id IS NOT NULL').size
  end

  protected

    def set_event
      self.event ||= Event.first
    end

    def reject_format
      if self.format_id == Format.group_format.id
        self.knockout_stage = nil
      elsif self.format_id == Format.knockout_format.id
        self.group_stage = nil
      end
    end
end
