class Category < ApplicationRecord
  # relationships
  belongs_to :parent, class_name: Category.name,
    foreign_key: :parent_id, optional: true

  has_many :tours, dependent: :destroy
end
