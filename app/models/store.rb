class Store < ApplicationRecord
    has_many :products, dependent: :destroy
    validates :name, presence: {message: "Debe poner nombre de tienda"}
end
