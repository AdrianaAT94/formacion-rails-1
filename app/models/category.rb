class Category < ApplicationRecord
    has_many :category_products, dependent: :destroy
    has_many :products, :through => :category_products
    validates :name, uniqueness: {message: "Ya existe una categoría con ese nombre"}, presence: {message: "Debe poner un nombre"}
end
