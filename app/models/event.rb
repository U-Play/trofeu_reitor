class Event < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :user

  has_many :news
  has_many :tournaments

  ## Attributes ##
  attr_accessible :deleted_at, :description, :name, :user_id

  ## Validations ##
  validates :user_id, presence: true
end
