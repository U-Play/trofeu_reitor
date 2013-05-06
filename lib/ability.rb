class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    guest
    send user.role.name unless user.nil? || user.role.nil?
  end

  protected

  def root
    admin
    can :manage, :all
  end

  def admin
    validator
    can :access, :admin
    can :read, ActiveAdmin::Page, name: "Dashboard"
    can :manage, [Tournament, Team, User, Match, Group, Sport]
  end

  def validator
    can :access, :admin
    can :read, [Tournament, Team]
    can :read, User
    can :validate, User.without_validation_finished
    can :invalidate, User.with_validation_requested
  end

  def blogger
    # TODO onde fica a zona admin do blog? no activeadmin?
  end

  def manager
    athlete
    can :access, :admin
    can :read, [Tournament, Team, User, Match]
    can :update, Team, id: @user.teams_as_manager.map(&:id)
  end

  def athlete
    can :update, User, id: @user.id, validation_state: 'validation_unprocessed'
    can :request_validation, User do |user|
      user.id == @user.id && user.can_request_validation?
    end
    # TODO can manage his own profile. vai haver um model Profile ou fica no User?
  end

  def guest
    can :read, User
  end

end
