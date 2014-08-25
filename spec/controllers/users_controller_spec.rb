require 'spec_helper'

describe UsersController do
  render_views
  common_lets

  before :all do
    Fracture.define_selector :new_user_link
    Fracture.define_selector :cancel_new_user_link
    Fracture.define_selector :edit_user_link
    Fracture.define_selector :cancel_edit_user_link
  end

  # stub strong params
  before { controller.stub(user_params: {}) }

  context 'not logged in' do
    before do
      sign_out :user
    end

    {index: :get, show: :get, new: :get, create: :post, edit: :get, update: :put, destroy: :delete}.each do |v, m|
      it "#{m} #{v} should logout" do
        self.send(m, v, id: user)
    should redirect_to new_user_session_path
  }
    end
  end

  context 'logged in as user' do
    before { sign_in user }

    describe 'GET index' do
      before do
        user; user_other
        get :index
      end

      it { should assign_to(:users).with_items([user]) }
      it { should render_template :index }
      it { should have_only_fractures(:new_user_link) }
      end

          describe 'GET show' do
      before { get :show, id: user }

    it { should assign_to(:user).with(user) }
    it { should render_template :show }
    it { should have_only_fractures(:edit_user_link) }
    end

    describe 'GET new' do
      before { get :new }

      it { should assign_to(:user).with_kind_of(User) }
      #it { should assign_to('user.parent').with(parent) }
      it { should render_template :new }
      it { should have_only_fractures :cancel_new_user_link }
      it { should have_a_form.that_is_new.with_path_of(users_path)}
    end

    describe 'POST create' do
      context 'valid' do
        before do
          User.any_instance.stub(:valid?).and_return(true)
          post :create
        end

        it { should redirect_to user_path(User.last) }
        it { should assign_to(:user).with(User.last) }
        #it { should assign_to('user.parent').with(parent) }
      end

      context 'invalid' do
        before do
          User.any_instance.stub(:valid?).and_return(false)
          post :create
        end
        it { should assign_to(:user).with_kind_of(User) }
        #it { should assign_to('user.parent').with(parent) }
        it { should render_template :new }
        it { should have_only_fractures :cancel_new_user_link }
        it { should have_a_form.that_is_new.with_path_of(users_path)}
      end
    end

    describe 'GET edit' do
      before { get :edit, id: user }

      it { should assign_to(:user).with(user) }
      it { should render_template :edit }
      it { should have_only_fractures :cancel_edit_user_link }
      it { should have_a_form.that_is_edit.with_path_of(user_path) }
    end

    describe 'PUT update' do
      context 'valid' do
        before do
          User.any_instance.stub(:valid?).and_return(true)
          put :update, id: user
        end

        it { should assign_to(:user).with(user) }
        it { should redirect_to user_path(user) }
      end
      context 'invalid' do
        before do
          user
          User.any_instance.stub(:valid?).and_return(false)
          put :update, id: user
        end

        it { should assign_to(:user).with(user) }
        it { should render_template :edit }
        it { should have_only_fractures :cancel_edit_user_link }
        it { should have_a_form.that_is_edit.with_path_of(user_path) }
      end
    end

    describe 'DELETE destroy' do
      before { delete :destroy, id: user }

      it { expect(User.find_by_id(user.id)).to be_nil }
      it { should redirect_to users_path }
    end
  end
end
