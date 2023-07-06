require 'rails_helper'

RSpec.describe User, type: :model do
    before(:each) do
        @user = User.create(name: 'User', email: 'user@example.com', password: 'password')
    end

    describe 'validations' do
        it 'should be vaild with valid attributes' do
            expect(@user).to be_valid
        end

        it 'should not be valid without name' do
            @user.name = nil
            expect(@user).not_to be_valid
        end

        it 'should not be valid without email' do
            @user.email = nil
            expect(@user).not_to be_valid
        end
    end

    describe 'associations' do
        it 'should have many categories' do
            user_categories = User.reflect_on_association(:categories)
            expect(user_categories.macro).to eq(:has_many)
        end

        it 'should have many money_transactions' do
            user_money_transactions = User.reflect_on_association(:money_transactions)
            expect(user_money_transactions.macro).to eq(:has_many)
        end
    end
end