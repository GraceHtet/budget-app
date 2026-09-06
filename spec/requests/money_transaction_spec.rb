require 'rails_helper'

RSpec.describe 'Money Transaction', type: :request do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'User', email: 'user@example.com', password: 'password')
    @category = Category.create(name: 'Category', author_id: @user.id)
    sign_in @user

    # attach an image to the category
    image_path = Rails.root.join('spec', 'fixtures', 'files', 'healthy-food.png')
    image = fixture_file_upload(image_path, 'image/png')
    @category.icon.attach(io: File.open(image.path), filename: 'healthy-food.png')
  end

  describe 'GET /index' do
    before(:each) do
      get category_money_transactions_path(@category)
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
      get new_category_money_transaction_path(category_id: @category.id)
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
