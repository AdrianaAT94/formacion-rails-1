class Product < ApplicationRecord
  belongs_to :store
  #belongs_to :category
  has_many :sizes, dependent: :destroy
  has_rich_text :description
  has_many_attached :images, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize: "100x100"
    attachable.variant :medium, resize: "300x300"
  end
  validates :name, :sku, presence: true
  validates :images, content_type: [:png, :jpg, :jpeg]
end
