class User < ApplicationRecord
    has_many :money_trans
    has_many :categories

    validates :name, presence: true
end