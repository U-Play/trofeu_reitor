class Tournament < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :sport
  belongs_to :format
  belongs_to :event

  has_one :group_stage
  has_one :knockout_stage

  has_many :teams
  has_many :matches
  has_many :groups
  # has_many :news

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  ## Attributes ##
  attr_accessible :contacts, :description, :end_date, :name, :rules, :start_date,
    :event_id, :sport_id, :format_id

  ## Validations ##
  validates :sport_id, presence: true
  validates :event_id, presence: true
  before_validation :set_event

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
end
