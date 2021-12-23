class Product < ApplicationRecord
  has_many :category_products, dependent: :destroy
  has_many :categories, :through => :category_products
  has_many :sizes, dependent: :destroy
  has_rich_text :description
  has_many_attached :images, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize: "100x100"
    attachable.variant :medium, resize: "300x300"
  end
  validates :name, :sku, :description, presence: {message: "Debe completar todos los campos"}
  validates :images, content_type: [:png, :jpg, :jpeg]
  validates :sku, uniqueness: {message: "Ya existe el sku introducido"}

  scope :search_category_id, ->(category_id_searched) { joins(:category_products).where("category_products.category_id = ?", category_id_searched) if category_id_searched.present? }
end