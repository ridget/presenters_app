require 'spec_helper'

describe PreferencesController do
  describe 'routing' do

    it('routes to #index') { get('/preferences').should route_to('preferences#index') }
    it('routes to #new') { get('/preferences/new').should route_to('preferences#new') }
    it('routes to #show') { get('/preferences/1').should route_to('preferences#show', id: '1') }
    it('routes to #edit') { get('/preferences/1/edit').should route_to('preferences#edit', id: '1') }
    it('routes to #create') { post('/preferences').should route_to('preferences#create') }
    it('routes to #update') { put('/preferences/1').should route_to('preferences#update', id: '1') }
    it('routes to #destroy') { delete('/preferences/1').should route_to('preferences#destroy', id: '1') }
  end
end
