class News < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :event
  belongs_to :tournament
  belongs_to :team
  belongs_to :match
  belongs_to :user

  ## Attributes ##
  attr_accessible :deleted_at
end
