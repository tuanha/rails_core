require 'rails_helper'

describe Admin::UsersController, type: :controller do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create :user }

  before do
    sign_in :user, user
  end

  describe 'GET Index' do
    it "redirect to home when user's not admin" do
      user.role = 'user'
      user.save
      get :index
      expect(response).to have_http_status(302)
    end

    it 'responds successfully with a HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('users/index')
    end
  end

  describe 'GET new' do
    before { get :new }
    it { expect(response).to be_success }
    it { expect(response).to have_http_status 200 }
    it { expect(response).to render_template :new }
  end

  describe 'GET show' do
    before { get :show, id: user.id }
    it { expect(response).to be_success }
    it { expect(response).to have_http_status 200 }
    it { expect(response).to render_template :show }
  end

  describe 'UPDATE' do
    context 'with invalid email' do
      before { post :update, id: user.id, user: { email: 'email_invalid'}}
      it { expect(response).to render_template :edit }
      it { expect(flash[:success]).to be_nil }
    end

    context 'with valid email' do
      before { post :update, id: user.id, user: { email: 'email_valid@gmail.com', id: user.id } }
      it { expect(response).to redirect_to action: :show }
      it { expect(flash[:success]).not_to be_nil }
    end
  end

  describe 'DELETE destroy' do
    before { delete :destroy, id: user.id }
    it { expect(response).to redirect_to action: :index }
    it { expect(flash[:success]).not_to be_nil }
  end

  describe 'POST create' do
    context 'with invalid email' do
      before { post :create, user: { email: 'email_invalid', password: '123123123', password_confirmation: '123123123' } }
      it { expect(response).to render_template :new }
      it { expect(flash[:success]).to be_nil }
    end
    context 'with valid email' do
      before { post :create, user: { email: 'valid@gmail.com', password: '123123123', password_confirmation: '123123123' } }
      it { expect(response).to redirect_to action: :show, id: User.last.id}
      it { expect(flash[:success]).not_to be_nil }
    end
  end

end
