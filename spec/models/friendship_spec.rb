require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before(:all) do
    User.create(id: 1, name: 'emmy', email: 'emmy@gmail.com', password: '123456', password_confirmation: '123456')
    User.create(id: 2, name: 'emma', email: 'emma@gmail.com', password: '123456', password_confirmation: '123456')
    @friendship = Friendship.create(requestor_id: 1, requestee_id: 2)
    @status = %i[pending accepted rejected]
  end

  it 'should have valid attributes' do
    expect(@friendship).to be_valid
  end

  it 'should update status to accepted' do
    @friendship.update(status: 'accepted')
    expect(Friendship.find_by_status('accepted')).to eq(@friendship)
  end

  it 'should update status to reject' do
    @friendship.update(status: 'rejected')
    expect(Friendship.find_by_status('rejected')).to eq(@friendship)
  end

  describe 'status' do
    it 'has the right index' do
      @status.each_with_index do |item, index|
        expect(described_class.statuses[item]).to eq index
      end
    end
  end

  describe 'Associations' do
    it { should belong_to(:requestor).without_validating_presence }

    it { should belong_to(:requestee).without_validating_presence }
  end

  describe 'Validations' do
    it { should validate_presence_of(:requestor) }

    it { should validate_presence_of(:requestee) }
  end
end
