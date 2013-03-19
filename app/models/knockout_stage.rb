class KnockoutStage < ActiveRecord::Base
  belongs_to :tournament
  attr_accessible :result_homologation, :third_place
end
