class Slider < ApplicationRecord
    has_one_attached :image, dependent: :destroy
    validates :name, presence: {message: "Debe poner nombre de slide"}
    validates :image, presence: {message: "Debe subir una imagen"}
    validates :image, attached: true, content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'Solo se admiten formatos png, jpg y jpeg' }
end
