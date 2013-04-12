class Match < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament
  belongs_to :location
  belongs_to :format
  belongs_to :winner, :class_name => "Team"
  belongs_to :team_one, :class_name => "Team"
  belongs_to :team_two, :class_name => "Team"

  has_many :penalties

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  has_many :match_referees, :inverse_of => :match
  has_many :referees, :through => :match_referees, :source => :referee

  has_many :highlight_occurrences
  has_many :highlight_athletes, :through => :highlight_occurrences, :source => :athlete
  has_many :highlights, :through => :highlight_occurrences

  ## Attributes ##
  attr_accessible :start_datetime, :position, :tournament_id, :location_id, :winner_id,
  :team_one_id, :team_two_id, :match_referees_attributes, :format, :format_id, :result_team_one,
  :result_team_two, :started, :ended

  accepts_nested_attributes_for :match_referees, :allow_destroy => true

  just_define_datetime_picker :start_datetime, :add_to_attr_accessible => true

  ## Validations ##
  validates :tournament_id, :location_id, :format, presence: true
  validate :end_after_started
  validate :start_with_two_teams

  ## Public Methods ##
  def athletes
    User.where(:id => (team_one.athletes + team_two.athletes))
  end

  def begin
    if pending?
      self.update_attribute :started, true
    end
  end

  def end
    if started?
      self.update_attribute :ended, true
    end
  end

  def ended?
    started && ended
  end

  def self.find_all_by_team(team)
   where('team_one_id = ? OR team_two_id = ?', team.id, team.id) 
  end

  def pending?
    !started && !ended
  end

  def ready?
    team_one && team_two
  end

  def result
    "#{result_team_one} - #{result_team_two}"
  end

  def started?
    started && !ended
  end

  def status
    ( started? && 'Started' ) || ( pending? && 'Pending' )  || ( ended? && 'Ended' )
  end

  def status_type
    ( started? && :error ) || ( pending? && :warning ) || ( ended? && :ok )
  end

  def teams
    Team.where( :id => team_one + team_two)
  end

  ## Protected Methods ##
  protected

  def end_after_started 
    errors.add(:ended, "match has to start before ending") if (!started && ended)
  end

  def start_with_two_teams
    errors.add(:started, "match must have two athletes defined") if started && (team_one.nil? || team_two.nil?)
  end
end
