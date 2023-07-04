class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :money_transactions, foreign_key: :author_id, dependent: :destroy
  has_many :categories, foreign_key: :author_id,dependent: :destroy

  validates :name, presence: true
end
