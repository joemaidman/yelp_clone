require 'rails_helper'

describe User, type: :model do

  it "has many restaurants" do
    user = User.new(email: 'test@test.com', password: 'password')
    expect(user).to have_many :restaurants
  end

  it "has many reviews" do
    user = User.new(email: 'test@test.com', password: 'password')
    expect(user).to have_many :reviews
  end
end
