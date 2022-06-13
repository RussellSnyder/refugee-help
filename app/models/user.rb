class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :groups, dependent: :destroy

  has_many :group_admins, dependent: :destroy
  has_many :admin_for_groups, through: :group_admins, source: :group

  ROLES = %w[User Admin SuperAdmin].freeze

  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: {
    case_sensitive: false
  }

  validates :password, length: { minimum: 10, allow_blank: true }
  validates :role, inclusion: { in: ROLES }

  def admin?
    role == 'Admin' || role == 'SuperAdmin'
  end

  def super_admin?
    role == 'SuperAdmin'
  end

  def upgrade_user_to_super_admin(user_id)
    unless super_admin?
      errors.add(:upgrade_user_to_super_admin,
                 'You must be a super admin to change a users role to super admin')
      return
    end

    user = User.find(user_id)
    user.role = 'SuperAdmin'

    user.save
  end

  def upgrade_user_to_admin_of_group(user_id, group_id)
    unless admin?
      errors.add(:upgrade_user_to_admin_of_group,
                 'You must be an admin to change users roles')
      return
    end
    unless super_admin? || (admin? && admin_for_groups.include?(group_id))
      errors.add(:upgrade_user_to_admin_of_group,
                 'You must be a super admin or an admin of the group you want to add user to')
      return
    end

    user_to_upgrade = User.find(user_id)
    unless user_to_upgrade
      errors.add(:upgrade_user_to_admin_of_group,
                 "User with id #{user_id}  does not exist")
      return
    end

    user_to_upgrade.update(role: 'Admin')

    group = Group.find(group_id)
    unless group
      errors.add(:upgrade_user_to_admin_of_group,
                 "Group with id #{user_id} does not exist")
      return
    end

    user_to_upgrade.admin_for_groups << group
    user_to_upgrade.save
  end

  scope :by_name, lambda {
    order(:name)
  }

  scope :not_admins, lambda {
    by_name.where('role = "User"')
  }
end
