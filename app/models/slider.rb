class Slider < ApplicationRecord
    has_many_attached :images, dependent: :destroy
    validates :name, :reference, presence: true
    validates :images, content_type: [:png, :jpg, :jpeg]
end
