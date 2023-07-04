class MoneyTran < ApplicationRecord
  belongs_to :user

  validates [:name, :amount], presence: true
end
