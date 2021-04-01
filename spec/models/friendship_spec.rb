require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before(:all) do
    @friendship = Friendship.create(requestor_id: 1, requestee_id: 2)
  end

  # it 'should have valid attributes' do
  #   expect(@user).to be_valid
  # end

  # it 'should find user by email' do
  #   expect(User.find_by_email('emmy@gmail.com')).to eq(@user)
  # end

  # it 'should update user' do
  #   @user.update(email: 'emma@gmail.com')
  #   expect(User.find_by_email('emma@gmail.com')).to eq(@user)
  # end

  # it 'is not valid without an email' do
  #   user = User.new(email: nil)
  #   expect(user).to_not be_valid
  # end

  describe 'Associations' do
    it { should belong_to(:requestor).without_validating_presence }

    it { should belong_to(:requestee).without_validating_presence }
  end

  describe 'Validations' do
    it { should validate_presence_of(:requestor) }

    it { should validate_presence_of(:requestee) }
  end
end
