require 'rails_helper'

describe User do
  let(:valid_attributes){
    { username: "moses",
      password: "password1",
      password_confirmation: "password1",
      email: "moses@test.com"
    }
  }

  it "is valid with valid attributes" do
    user = User.new(valid_attributes)
    expect(user).to be_valid
  end
end