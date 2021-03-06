require 'rails_helper'

describe User, type: :model do
  user = User.new(email: "test@example.com", password: "password")
  it 'has many reviewed restaurants' do
    expect(user).to have_many(:reviewed_restaurants)
  end
end
