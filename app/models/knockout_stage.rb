class KnockoutStage < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament

  ## Attributes ##
  attr_accessible :result_homologation, :third_place, :tournament_id

  ## Validations ##
  validates :tournament_id, presence: true

end
