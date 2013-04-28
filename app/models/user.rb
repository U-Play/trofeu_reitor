class User < ActiveRecord::Base
  include ParanoiaInterface

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :invitable

  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :remember_me,
                  :first_name,
                  :last_name,
                  :username,
                  :course,
                  :student_number,
                  :sports_number,
                  :picture,
                  :role_id

  has_attached_file :picture,
                    styles: { default: "300x300>", thumb: "150x150>" },
                    default_url: '/assets/defaults/user_picture_:style.png'

  ## Relations ##
  belongs_to :role

  has_many :events
  has_many :teams_as_manager, :class_name => "Team", foreign_key: "manager_id", inverse_of: :manager
  has_many :penalties
  # has_many :news

  has_many :news_references, :as => :newsable
  has_many :news, through: :news_references

  has_many :team_athletes, :dependent => :destroy
  has_many :teams_as_athlete, :through => :team_athletes

  has_many :team_referees
  has_many :teams_as_referee, :through => :team_referees

  has_many :match_referees
  has_many :matches, :through => :match_referees

  has_many :highlight_occurrences
  has_many :matches, :through => :highlight_occurrences
  has_many :highlights, :through => :highlight_occurrences

  # Scopes
  scope :with_validation_finished,    -> { where validation_state: :validated }
  scope :without_validation_finished, -> { where validation_state: [:validation_requested, :validation_unprocessed] }
  scope :with_validation_requested,   -> { where validation_state: :validation_requested }

  scope :by_role, -> (role_name) { where role_id: Role.find_by_name(role_name) }

  # accepts_nested_attributes_for :team_athletes, :allow_destroy => true


  before_create :set_default_role
  # after_create :send_invitation_email

  state_machine :validation_state, initial: :validation_unprocessed do
    # validation_unprocessed
    # validation_requested
    # validated
    event(:validate) { transition [:validation_unprocessed, :validation_requested] => :validated }
    event(:request_validation) { transition :validation_unprocessed => :validation_requested }
    event(:invalidate) { transition :validation_unprocessed => same, :validation_requested => :validation_unprocessed }

    after_transition any => :validation_requested do |user, transition|
      AdminMailer.validation_requested(user).deliver
    end

    after_transition any => :validated do |user, transition|
      UserMailer.validated(user).deliver
    end

    after_transition any => :validation_unprocessed do |user, transition|
      UserMailer.invalidated(user).deliver
    end
  end

  ## Public Methods ##

  def name
    "#{first_name} #{last_name}".strip.presence || email
  end

  def name_with_team(match)
    if match.team_one.has_athlete?(self)
      "#{name} (#{match.team_one.name})".strip
    elsif match.team_two.has_athlete?(self)
      "#{name} (#{match.team_two.name})".strip
    end
  end

  def password_required?
    new_record? ? false : super
  end

  def promote_to_manager(team)
    set_role('manager') if role.nil? || role.name == 'athlete'
    UserMailer.promoted_to_manager(self, team).deliver
  end

  def tournaments
    Tournament.joins(:event => :user).where(:events => {:user_id => id})
  end

  def self.find_or_invite_by_email(email)
    user = User.find_by_email(email)
    return user || User.invite!(email: email)
  end

  protected

    def set_role(new_role)
      self.update_attributes role_id: Role.find_by_name(new_role).id
    end

    def set_default_role
      return unless role.nil?
      self.role = Role.default_role
    end
end
