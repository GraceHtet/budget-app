require 'rails_helper'

RSpec.describe 'Category', type: :request do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'User', email: 'user@example.com', password: 'password')
    sign_in @user
  end

  describe 'GET /index' do
    before(:each) do
      get categories_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'get correct response status' do
      assert_equal 'index', @controller.action_name
    end

    it 'renders an index template' do
      assert_template :index
    end
  end

  describe 'GET /new' do
    before(:each) do
      get new_category_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'get correct response status' do
      assert_equal 'new', @controller.action_name
    end

    it 'renders an index template' do
      assert_template :new
    end
  end
end
