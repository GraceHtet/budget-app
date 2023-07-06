require 'rails_helper'

RSpec.describe "Homes", type: :request do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    get home_path
  end
  describe 'GET /index' do
    it 'renders a successfull response' do
      expect(response).to have_http_status(200)
    end

    it 'get correct response status' do
      assert_equal 'index', @controller.action_name
    end

    it 'renders an index template' do
      assert_template :index
    end

    it 'has render a categories#index template if a user is signned in' do
      user = User.create(name: 'User', email: 'user@example.com', password: 'password')
      sign_in user

      get home_path

      expect(response).to redirect_to(categories_path)
    end
  end
end
