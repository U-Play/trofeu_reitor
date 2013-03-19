class Ability
  include CanCan::Ability

  def initialize(user)
    send user.role.name unless user.nil?
  end

  def root
    admin
  end

  def admin
    can :access, :admin
  end

  def athlete
  end

end
