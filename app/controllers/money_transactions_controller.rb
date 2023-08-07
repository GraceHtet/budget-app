class MoneyTransactionsController < ApplicationController
  before_action :find_category, only: %i[index new create]

  def index
    @transactions = @category.money_transactions
  end

  def new
    @transaction = MoneyTransaction.new
  end

  def create
    @transaction = MoneyTransaction.new(money_transaction_params.merge(author: current_user))

    if @transaction.save
      category_ids = params[:money_transaction][:category_ids]

      if category_ids.present?
        category_ids.each do |category_id|
          category = Category.find_by(id: category_id)
          category.money_transactions << @transaction if category.present?
        end
      end

      redirect_to category_money_transactions_path(@category), notice: 'Transaction was successfully created.'
    else
      render :new, alert: "Transaction wasn't created."
    end
  end

  private

  def find_category
    @category = Category.includes(:author).find_by(id: params[:category_id])
  end

  def money_transaction_params
    params.require(:money_transaction).permit(:name, :amount)
  end
end
