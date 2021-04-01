require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # before(:all) do
  #   User.create(id: 1, name: 'emmy', email: 'emmy@gmail.com', password: '123456', password_confirmation: '123456')
  #   User.create(id: 2, name: 'emma', email: 'emma@gmail.com', password: '123456', password_confirmation: '123456')
  #   @friendship = Friendship.create(requestor_id: 1, requestee_id: 2)
  # end

  let(:user) { FactoryGirl.create(:user) }

  before do
    user.save
    sign_in user
  end

  describe 'GET #index' do
    before do
      get :index
    end

    it 'should return a successful response' do
      expect(response).to have_http_status(200)
    end

    it 'should render the index view' do
      expect(response).to render_template :index
    end
  end
end
