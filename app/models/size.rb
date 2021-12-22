class Size < ApplicationRecord    
  belongs_to :product
  validates :name, :ean, :price, :stock, presence: {message: "Debe completar todos los campos"}
  validates :ean, uniqueness: {message: "Ya existe el ean introducido"}
end
