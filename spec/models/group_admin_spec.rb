require 'rails_helper'

RSpec.describe GroupAdmin, type: :model do
  it 'deletes entries with associated user when the user is deleted'
  it 'deletes entries with associated groups when the group is deleted'
end
