class User < ApplicationRecord
    has_many :money_trans
    
    validates :name, presence: true
end
