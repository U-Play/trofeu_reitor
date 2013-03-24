class Tournament < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :sport
  belongs_to :format
  belongs_to :event

  has_one :group_stage
  has_one :knockout_stage
  has_one :format

  has_many :teams
  has_many :matches
  # has_many :news

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  ## Attributes ##
  attr_accessible :contacts, :description, :end_date, :name, :rules, :start_date,
                  :event_id, :sport_id, :format_id

  ## Validations ##
  validates :sport_id, presence: true
  validates :event_id, presence: true
end
