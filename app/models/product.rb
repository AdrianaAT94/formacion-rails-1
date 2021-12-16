class Product < ApplicationRecord
  belongs_to :store
  belongs_to :category
  has_many :sizes, dependent: :destroy
  has_rich_text :description
  has_one_attached :image
  validates :name, :reference, presence: true
end
