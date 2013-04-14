class Group < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament

  has_many :teams

  ## Attributes ##
  attr_accessible :name, :tournament, :team_ids

  ## Validations ##
  validates :tournament_id, presence: true
  # validate :number_of_teams_cannot_surpass_maximum
  
  ## Public Methods ##
  def max_slots
    tournament.group_stage.max_slots
  end

  def slots_occupied
    teams.count
  end

  ## Private Methods ##
  protected
  def number_of_teams_cannot_surpass_maximum
    errors.add(:teams, 'cannot surpass the maximum slots per group') if teams.count > max_slots
  end
end
