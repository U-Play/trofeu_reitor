class NewsReference < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :newsable, polymorphic: true
  belongs_to :news

  ## Attributes ##
end
