class Product < ApplicationRecord
  belongs_to :store
  #belongs_to :category
  has_many :sizes, dependent: :destroy
  has_rich_text :description
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end
  validates :name, :reference, presence: true
end
