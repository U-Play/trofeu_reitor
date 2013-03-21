class News < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  # belongs_to :event
  # belongs_to :tournament
  # belongs_to :team
  # belongs_to :match
  # belongs_to :user

  has_many :news_references
  has_many :events, through: :news_references, :source => :newsable, :source_type => 'Event'
  has_many :tournaments, through: :news_references, :source => :newsable, :source_type => 'Tournament'
  has_many :teams, through: :news_references, :source => :newsable, :source_type => 'Team'
  has_many :matches, through: :news_references, :source => :newsable, :source_type => 'Match'
  has_many :users, through: :news_references, :source => :newsable, :source_type => 'User'

  ## Attributes ##
  attr_accessible :deleted_at
end
