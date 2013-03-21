class Event < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :user

  has_many :tournaments
  # has_many :news

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  ## Attributes ##
  attr_accessible :deleted_at, :description, :name, :user_id

  ## Validations ##
  validates :user_id, presence: true
end
