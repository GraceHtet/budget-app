require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @user = User.create(name: 'User', email: 'user@example.com', password: 'password')
    @category = Category.create(name: 'Category',author_id: @user.id)
    @transaction = @category.money_transactions.build(name: 'Transaction', amount: 100, author_id: @user.id)
  end

  describe 'validations' do
    it 'should be vaild with valid attributes' do
      expect(@transaction).to be_valid
    end
  
    it 'should not be valid without author' do
      @transaction.author_id = nil
      expect(@transaction).not_to be_valid
    end
  
    it 'should not be valid without name' do
      @transaction.name = nil
      expect(@transaction).not_to be_valid
    end

    it 'should not be valid without amount' do
      @transaction.amount = nil
      expect(@transaction).not_to be_valid
    end

    it 'should not be valid if amount is less than 0' do
      @transaction.amount = -1
      expect(@transaction).not_to be_valid
    end
  end

  describe 'associations' do
    it 'should have one user' do
        transaction_user = MoneyTransaction.reflect_on_association(:author)
        expect(transaction_user.macro).to eq(:belongs_to)
    end

    it 'should have and belongs to many categories' do
        categories_money_transactions = MoneyTransaction.reflect_on_association(:categories)
        expect(categories_money_transactions.macro).to eq(:has_and_belongs_to_many)
    end
  end
end
