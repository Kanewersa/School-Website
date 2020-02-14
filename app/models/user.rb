class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :authentication_keys => [:username]

  scope :active_users, -> { where(status: "active") }
  scope :suspended_users, -> { where(status: "suspended") }
  scope :inactive_users, -> { where(status: "inactive") }

  validates :username, uniqueness: { case_sensitive: true }, presence: true
  validates :password, length: {minimum: 4}, presence: true
  has_one_attached :avatar

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  #####
  # Change user status
  #####

  def activate
    self.status = "active"
    self.save
  end

  def deactivate
    self.status = "inactive"
    self.save
  end

  def suspend
    self.status = "suspended"
    self.save
  end

  #def active_for_authentication?
  #  super && account_active?
  #end

end
