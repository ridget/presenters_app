require 'spec_helper'

describe UsersController do
  describe 'routing' do

    it('routes to #index') { get('/users').should route_to('users#index') }
    it('routes to #new') { get('/users/new').should route_to('users#new') }
    it('routes to #show') { get('/users/1').should route_to('users#show', id: '1') }
    it('routes to #edit') { get('/users/1/edit').should route_to('users#edit', id: '1') }
    it('routes to #create') { post('/users').should route_to('users#create') }
    it('routes to #update') { put('/users/1').should route_to('users#update', id: '1') }
    it('routes to #destroy') { delete('/users/1').should route_to('users#destroy', id: '1') }
  end
end
