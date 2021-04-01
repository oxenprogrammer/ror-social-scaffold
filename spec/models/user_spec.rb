require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.create(name: 'emmy', email: 'emmy@gmail.com', password: '123456', password_confirmation: '123456')
  end

  it 'should have valid attributes' do
    expect(@user).to be_valid
  end
end
