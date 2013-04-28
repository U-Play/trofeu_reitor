class Format < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  has_many :tournaments
  has_many :matches

  ## Attributes ##
  attr_accessible :description, :name, :deleted_at

  ## Validations ##
  validates :name, presence: true

  def self.knockout_format
    Format.find_by_name('Knockout Stage')
  end

  def self.group_format
    Format.find_by_name('Group Stage')
  end

  def self.multi_stage_format
    Format.find_by_name('Multi Stage')
  end
end
