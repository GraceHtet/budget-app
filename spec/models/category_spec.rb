require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @user = User.create(name: 'User', email: 'user@example.com', password: 'password')
    @category = Category.create(name: 'Category', author_id: @user.id)
  end

  describe 'validations' do
    it 'should be vaild with valid attributes' do
      expect(@category).to be_valid
    end

    it 'should not be valid without author' do
      @category.author_id = nil
      expect(@category).not_to be_valid
    end

    it 'should not be valid without name' do
      @category.name = nil
      expect(@category).not_to be_valid
    end
  end

  describe 'associations' do
    it 'should have one user' do
      category_user = Category.reflect_on_association(:author)
      expect(category_user.macro).to eq(:belongs_to)
    end

    it 'should have and belongs to many money_transactions' do
      categories_money_transactions = Category.reflect_on_association(:money_transactions)
      expect(categories_money_transactions.macro).to eq(:has_and_belongs_to_many)
    end
  end
end
