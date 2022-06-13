class Group < ApplicationRecord
  belongs_to :user # this is the main user in charge or a group

  has_many :group_posts, dependent: :destroy
  has_many :posts, through: :group_posts

  has_many :group_admins, dependent: :destroy
  has_many :admins, through: :group_admins, source: :user

  def main_contact
    user
  end
end
