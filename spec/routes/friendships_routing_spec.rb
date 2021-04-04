require 'rails_helper'

RSpec.describe FriendshipsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/users/1/friendships').to route_to('friendships#create', user_id: '1')
    end

    it 'routes to #update' do
      expect(patch: '/users/1/friendships/1').to route_to('friendships#update', user_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/users/1/friendships/1').to route_to('friendships#destroy', user_id: '1', id: '1')
    end

    it 'routes to #show' do
      expect(get: '/users/1/friendships/1').to route_to('friendships#show', user_id: '1', id: '1')
    end
  end
end
