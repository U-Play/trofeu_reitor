class Match < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :tournament
  belongs_to :location
  belongs_to :winner, :class_name => "Team"
  belongs_to :team_one, :class_name => "Team"
  belongs_to :team_two, :class_name => "Team"

  has_many :penalties

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  has_many :match_referees, :inverse_of => :match
  has_many :referees, :through => :match_referees, :source => :referee

  has_many :highlight_occurrences
  has_many :athletes, :through => :highlight_occurrences, :source => :user
  has_many :highlights, :through => :highlight_occurrences

  ## Attributes ##
  attr_accessible :end_date, :group, :position, :start_date, :tournament_id, :location_id,
    :winner_id, :team_one_id, :team_two_id, :match_referees_attributes

  accepts_nested_attributes_for :match_referees, :allow_destroy => true

  ## Validations ##
  validates :tournament_id, :location_id, presence: true
  validate :start_before_end

  def start_before_end
    return unless start_date and end_date
    if (start_date > end_date)
      errors.add(:start_date, "needs to be lesser or equal to the end date")
    end
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
end
