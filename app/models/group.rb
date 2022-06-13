class Group < ApplicationRecord
  belongs_to :user

  def main_contact
    user
  end
end
