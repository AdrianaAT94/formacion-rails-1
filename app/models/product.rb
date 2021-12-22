class Product < ApplicationRecord
  has_many :category_products, dependent: :destroy
  has_many :categories, :through => :category_products
  belongs_to :store
  has_many :sizes, dependent: :destroy
  has_rich_text :description
  has_many_attached :images, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize: "100x100"
    attachable.variant :medium, resize: "300x300"
  end
  validates :name, :sku, :description, presence: {message: "Debe completar todos los campos"}
  validates :images, content_type: [:png, :jpg, :jpeg]
  validates :sku, uniqueness: {message: "Ya existe el sku introducido"}

  scope :search_name, ->(name_searched) { where("LOWER(name) || UPPER(name) LIKE (?)", "%#{name_searched}%") if name_searched.present? }
end
