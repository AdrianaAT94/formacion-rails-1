class Size < ApplicationRecord    
  belongs_to :product
  validates :name, :ean, :price, :stock, presence: true
end
