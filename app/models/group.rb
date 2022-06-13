class Group < ApplicationRecord
  belongs_to :user

  has_many :group_posts, dependent: :destroy
  has_many :posts, through: :group_posts

  def main_contact
    user
  end
end
