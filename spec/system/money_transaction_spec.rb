require 'rails_helper'

RSpec.describe 'Money Transaction', type: :system do
    include Devise::Test::IntegrationHelpers

    before(:each) do
        @user = User.create(name: 'User', email: 'user@example.com', password: 'password')
        @category = Category.create(name: 'Category 1',author_id: @user.id)
        sign_in @user

        #attach an image to the category
        image_path = Rails.root.join('spec', 'fixtures', 'files','healthy-food.png')
        image = fixture_file_upload(image_path, 'image/png')
        @category.icon.attach(io: File.open(image.path), filename: 'healthy-food.png')

        @transaction1 = @category.money_transactions.create(name: 'Transaction one', amount: 100, author_id: @user.id)
        
        @transaction2 = @category.money_transactions.create(name: 'Transaction two', amount: 150, author_id: @user.id)
    end

    describe 'user visit the category page' do
        before(:each) do
            visit category_money_transactions_path(@category)
        end

        scenario 'I can see the page name' do
            assert_text 'Transactions'
        end

        scenario 'I can see the Transaction title' do
            assert_text @transaction1.name
        end

        scenario 'I can see the Transaction amount' do
            assert_text @transaction1.amount
        end

        scenario 'it should show total amount' do
            assert_text 'Total amount: 250.0 $'
        end

        scenario 'it should redirect to categories page' do
            click_link "🡨"

            assert_current_path categories_path
        end

        scenario 'it should redirect to new money transaction page' do
            click_link '+ New Transaction'

            assert_current_path new_category_money_transaction_path(category_id: @category.id)
        end
    end
end