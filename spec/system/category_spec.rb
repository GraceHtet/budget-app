require 'rails_helper'

RSpec.describe 'Category', type: :system do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'User', email: 'user@example.com', password: 'password')
    @category = Category.create(name: 'Category 1', author_id: @user.id)
    sign_in @user

    # attach an image to the category
    image_path = Rails.root.join('spec', 'fixtures', 'files', 'healthy-food.png')
    image = fixture_file_upload(image_path, 'image/png')
    @category.icon.attach(io: File.open(image.path), filename: 'healthy-food.png')

    @transaction1 = @category.money_transactions.create(name: 'Transaction one', amount: 100, author_id: @user.id)
    @transaction2 = @category.money_transactions.create(name: 'Transaction two', amount: 150, author_id: @user.id)
  end

  describe 'user visit the category page' do
    before(:each) do
      visit categories_path
    end

    scenario 'I can see the page name' do
      assert_text 'Categories'
    end

    scenario 'I can see the Category title' do
      assert_text @category.name
    end

    scenario 'I can see the Category icon' do
      expect(page).to have_css 'img.icon[src*="healthy-food.png"]'
    end

    scenario 'it should show total amount' do
      assert_text 'Total amount: 250.0 $'
    end

    scenario 'it should redirect to transaction page' do
      click_link @category.name

      assert_current_path category_money_transactions_path(@category)
    end

    scenario 'it should redirect to new category page' do
      click_link '+ New Category'

      assert_current_path new_category_path
    end
  end
end
