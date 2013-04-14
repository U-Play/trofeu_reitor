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
<<<<<<< HEAD
  attr_accessible :end_date, :group, :position, :start_date, :tournament_id, :location_id,
    :knockout_index, :winner_id, :team_one_id, :team_two_id, :match_referees_attributes
||||||| merged common ancestors
  attr_accessible :end_date, :group, :position, :start_date, :tournament_id, :location_id,
    :winner_id, :team_one_id, :team_two_id, :match_referees_attributes
=======
  attr_accessible :start_datetime, :position, :tournament_id, :location_id, :winner_id,
  :team_one_id, :team_two_id, :match_referees_attributes, :format, :format_id, :result_team_one,
  :result_team_two, :started, :ended
>>>>>>> merged from ba/tournament_crud

  accepts_nested_attributes_for :match_referees, :allow_destroy => true

  just_define_datetime_picker :start_datetime, :add_to_attr_accessible => true

  ## Validations ##
<<<<<<< HEAD
  validates :tournament_id, presence: true 
  #validates :location_id, presence: true
  validate :start_before_end
||||||| merged common ancestors
  validates :tournament_id, :location_id, presence: true
  validate :start_before_end
=======
  validates :tournament_id, :location_id, :format, presence: true
  validate :end_after_started
  validate :start_with_two_teams

  ## Public Methods ##
  def athletes
    User.where(:id => (team_one.athletes + team_two.athletes))
  end
>>>>>>> merged from ba/tournament_crud

<<<<<<< HEAD
  ## Scopes ##

  scope :finished, lambda { where("winner_id IS NOT NULL")}

  def start_before_end
    return unless start_date and end_date
    if (start_date > end_date)
      errors.add(:start_date, "needs to be lesser or equal to the end date")
||||||| merged common ancestors
  def start_before_end
    return unless start_date and end_date
    if (start_date > end_date)
      errors.add(:start_date, "needs to be lesser or equal to the end date")
=======
  def begin
    if pending?
      self.update_attribute :started, true
>>>>>>> merged from ba/tournament_crud
    end
  end

<<<<<<< HEAD
  def loser
    match = nil
    if self.winner_id == self.team_one_id
      match = self.team_two
    elsif self.winner_id == self.team_two_id
      match = self.team_one
    end
    return match
  end

  ## Public Methods ##
  # def get_unselected_referees_and_order_by_name
  #   # creates an array for all match_referees that the match does not currently have selected
  #   # and builds them in the match
  #   (User.all - self.referees).each do |p| #TODO so referees
  #     self.match_referees.build(:referee => p) unless self.match_referees.map(&:referee_id).include?(p.id)
  #   end
  #   # to ensure that all referees are always shown in a consistent order
  #   self.match_referees.sort_by! {|x| x.referee.name}
  # end
||||||| merged common ancestors
  ## Public Methods ##
  # def get_unselected_referees_and_order_by_name
  #   # creates an array for all match_referees that the match does not currently have selected
  #   # and builds them in the match
  #   (User.all - self.referees).each do |p| #TODO so referees
  #     self.match_referees.build(:referee => p) unless self.match_referees.map(&:referee_id).include?(p.id)
  #   end
  #   # to ensure that all referees are always shown in a consistent order
  #   self.match_referees.sort_by! {|x| x.referee.name}
  # end
=======
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
>>>>>>> merged from ba/tournament_crud
end
