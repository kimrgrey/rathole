class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :index, :show, :new, :create, :edit, :update, :destroy, :to => :crud

    can :crud, User, :id => user.id
    can [:read, :subscribe, :unsubscribe], User
    can :crud, Post, :user_id => user.id, :deleted_at => nil
    can [:read, :subscribe, :unsubscribe], Post, :state => Post.states[:published], :deleted_at => nil
    can :crud, Comment, :user_id => user.id, :deleted_at => nil
    can :read, Comment, :deleted_at => nil
    can :crud, Bug, :post => { :user_id => user.id }
    can :read, Bug, :reporter_id => user.id
    can :crud, Picture, :user_id => user.id
    can :create, Claim
    can :read, Subscription
    can :read, Sticker
    can :read, Section
    can :crud, Section, :user_id => user.id

    user.roles.each do |role|
      public_send(role, user) if respond_to?(role)
    end
  end

  def admin(user)
    can :crud, User
    can [:crud, :show_on_main], Post
    can :crud, Comment
  end
end
