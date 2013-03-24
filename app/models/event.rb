class Event < ActiveRecord::Base
  include ParanoiaInterface

  ## Relations ##
  belongs_to :user

  has_many :tournaments

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  ## Attributes ##
  attr_accessible :description, :name, :user_id, :start_date, :end_date

  ## Validations ##
  validates :user_id, :name, :start_date, presence: true
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