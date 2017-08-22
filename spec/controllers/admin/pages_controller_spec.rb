require 'rails_helper'

describe Admin::PagesController, type: :controller do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create :user }

  before do
    sign_in :user, user
  end

  describe 'GET dashboard' do
    it "redirect to home when user's not admin" do
      user.role = 'user'
      user.save
      get :dashboard
      expect(response).to have_http_status(302)
    end

    it 'responds successfully with a HTTP 200 status code' do
      get :dashboard
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :dashboard
      expect(response).to render_template('pages/dashboard')
    end
  end

end
