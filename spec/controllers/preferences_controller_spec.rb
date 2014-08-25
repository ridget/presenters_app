require 'spec_helper'

describe PreferencesController do
  render_views
  common_lets

  before :all do
    Fracture.define_selector :new_preference_link
    Fracture.define_selector :cancel_new_preference_link
    Fracture.define_selector :edit_preference_link
    Fracture.define_selector :cancel_edit_preference_link
  end

  # stub strong params
  before { controller.stub(preference_params: {}) }

  context 'not logged in' do
    before do
      sign_out :user
    end

    {index: :get, show: :get, new: :get, create: :post, edit: :get, update: :put, destroy: :delete}.each do |v, m|
      it "#{m} #{v} should logout" do
        self.send(m, v, id: preference)
    should redirect_to new_user_session_path
  }
    end
  end

  context 'logged in as user' do
    before { sign_in user }

    describe 'GET index' do
      before do
        preference; preference_other
        get :index
      end

      it { should assign_to(:preferences).with_items([preference]) }
      it { should render_template :index }
      it { should have_only_fractures(:new_preference_link) }
      end

          describe 'GET show' do
      before { get :show, id: preference }

    it { should assign_to(:preference).with(preference) }
    it { should render_template :show }
    it { should have_only_fractures(:edit_preference_link) }
    end

    describe 'GET new' do
      before { get :new }

      it { should assign_to(:preference).with_kind_of(Preference) }
      #it { should assign_to('preference.parent').with(parent) }
      it { should render_template :new }
      it { should have_only_fractures :cancel_new_preference_link }
      it { should have_a_form.that_is_new.with_path_of(preferences_path)}
    end

    describe 'POST create' do
      context 'valid' do
        before do
          Preference.any_instance.stub(:valid?).and_return(true)
          post :create
        end

        it { should redirect_to preference_path(Preference.last) }
        it { should assign_to(:preference).with(Preference.last) }
        #it { should assign_to('preference.parent').with(parent) }
      end

      context 'invalid' do
        before do
          Preference.any_instance.stub(:valid?).and_return(false)
          post :create
        end
        it { should assign_to(:preference).with_kind_of(Preference) }
        #it { should assign_to('preference.parent').with(parent) }
        it { should render_template :new }
        it { should have_only_fractures :cancel_new_preference_link }
        it { should have_a_form.that_is_new.with_path_of(preferences_path)}
      end
    end

    describe 'GET edit' do
      before { get :edit, id: preference }

      it { should assign_to(:preference).with(preference) }
      it { should render_template :edit }
      it { should have_only_fractures :cancel_edit_preference_link }
      it { should have_a_form.that_is_edit.with_path_of(preference_path) }
    end

    describe 'PUT update' do
      context 'valid' do
        before do
          Preference.any_instance.stub(:valid?).and_return(true)
          put :update, id: preference
        end

        it { should assign_to(:preference).with(preference) }
        it { should redirect_to preference_path(preference) }
      end
      context 'invalid' do
        before do
          preference
          Preference.any_instance.stub(:valid?).and_return(false)
          put :update, id: preference
        end

        it { should assign_to(:preference).with(preference) }
        it { should render_template :edit }
        it { should have_only_fractures :cancel_edit_preference_link }
        it { should have_a_form.that_is_edit.with_path_of(preference_path) }
      end
    end

    describe 'DELETE destroy' do
      before { delete :destroy, id: preference }

      it { expect(Preference.find_by_id(preference.id)).to be_nil }
      it { should redirect_to preferences_path }
    end
  end
end
