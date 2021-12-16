class Size < ApplicationRecord    
  belongs_to :product
  validates :name, :reference, :price, :stock, presence: true
end
