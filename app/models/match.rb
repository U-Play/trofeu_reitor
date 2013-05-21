class Match < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament
  belongs_to :location
  belongs_to :format
  belongs_to :winner, :class_name => "Team"
  belongs_to :team_one, :class_name => "Team"
  belongs_to :team_two, :class_name => "Team"
  belongs_to :group

  has_many :penalties
  has_many :team_data, :class_name => "TeamData", :dependent => :destroy

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  has_many :match_referees, :inverse_of => :match
  has_many :referees, :through => :match_referees, :source => :referee

  has_many :highlight_occurrences
  has_many :highlight_athletes, :through => :highlight_occurrences, :source => :athlete
  has_many :highlights, :through => :highlight_occurrences

  ## Attributes ##
  attr_accessible :start_datetime, :position, :tournament_id, :location_id, :winner_id,
                  :team_one_id, :team_two_id, :match_referees_attributes, :format, :format_id,
                  :started, :ended, :knockout_index, :group_round, :group_id

  accepts_nested_attributes_for :match_referees, :allow_destroy => true

  just_define_datetime_picker :start_datetime, :add_to_attr_accessible => true

  ## Validations ##
  validates :tournament, presence: true 
  validates :format, presence: true
  validate :end_after_started
  validate :start_with_two_teams

  ## Callbacks ##
  before_save :team_with_team_data
  
  ## Scopes ##
  scope :finished, lambda { where("winner_id IS NOT NULL")}
  scope :stage, lambda { |stage| where(knockout_index: stage) }

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
  
  def loser
    match = nil
    if self.winner_id == self.team_one_id
      match = self.team_two
    elsif self.winner_id == self.team_two_id
      match = self.team_one
    end
    return match
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

  def result_team_one
    team_one_data.try(:result)
  end

  def result_team_two
    team_two_data.try(:result)
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

  def team_one_data
    team_data.where( :team_id => team_one.id ).first if team_one
  end

  def team_two_data
    team_data.where( :team_id => team_two.id ).first if team_two
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
      errors.add(:started, "match must have two teams defined") if started && (team_one.nil? || team_two.nil?)
    end

    def team_with_team_data
      if team_one and team_one_data.nil?
        self.team_data.build team: team_one
      end
      if team_two and team_two_data.nil?
        self.team_data.build team: team_two
      end
    end
end
