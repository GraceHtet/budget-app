class Category < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_one_attached :icon, dependent: :destroy

  has_and_belongs_to_many :money_transactions, dependent: :destroy

  validates :name, presence: true
end
