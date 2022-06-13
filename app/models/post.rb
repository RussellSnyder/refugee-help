class Post < ApplicationRecord
  STATUSES = %w[Open Pending Expired Closed].freeze

  belongs_to :user

  has_many :group_posts, dependent: :destroy
  has_many :groups, through: :group_posts

  validates :status, inclusion: { in: STATUSES }
end
