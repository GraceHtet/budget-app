class CreateJoinTableCategoriesMoneyTransactions < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :money_transactions do |t|
      # t.index [:category_id, :money_transaction_id]
      # t.index [:money_transaction_id, :category_id]
    end
  end
end
