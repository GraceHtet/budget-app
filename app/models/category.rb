class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :money_transactions, dependent: :destroy

  has_one_attached :icon, dependent: :destroy

  validates :name, presence: true
end
