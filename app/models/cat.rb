class Cat < ApplicationRecord
  has_many :cat_toy
  has_many :toys, through: :cat_toy, dependent: :destroy
end
