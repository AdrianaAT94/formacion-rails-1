class Slider < ApplicationRecord
    has_one_attached :image, dependent: :destroy
    validates :name, :image, presence: true
    validates :image, content_type: [:png, :jpg, :jpeg]
end
