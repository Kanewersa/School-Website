class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :authentication_keys => [:username]
  validates :username, uniqueness: true
  has_one_attached :avatar
  #after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def assign_default_status
    self.status = "active"
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  #def active_for_authentication?
  #  super && account_active?
  #end

end
