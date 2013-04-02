class Tournament < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :sport
  belongs_to :format
  belongs_to :event

  has_one :group_stage
  has_one :knockout_stage

  has_many :teams, :order => 'id'
  has_many :matches
  # has_many :news

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  ## Attributes ##
  attr_accessible :contacts, :description, :end_date, :name, :rules, :start_date,
    :event_id, :sport_id, :format_id

  ## Validations ##
  #validates :sport_id, presence: true
  validates :event_id, presence: true
  validates :name, presence: true
  before_validation :set_event

  protected

  def set_event
    self.event ||= Event.first
  end
end
