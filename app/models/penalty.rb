class Penalty < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :match
  belongs_to :team
  belongs_to :athlete, :class_name => "User"

  ## Attributes ##
  attr_accessible :name, :description, :end_date, :start_date, :match_id, :team_id, :athlete_id

  ## Validations ##
  validates :name, presence: true
  validate :start_before_end

  def start_before_end
    return unless start_date and end_date
    if (start_date > end_date)
      errors.add(:start_date, "needs to be lesser or equal to the end date")
    end
  end

  ## Scopes ##
  scope :on_going,  -> { where('start_date <= ? and end_date >= ?', Time.now, Time.now) }
  scope :coming,    -> { where('start_date > ?', Time.now) }
  scope :past,      -> { where('end_date < ?', Time.now) }

end
