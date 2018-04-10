class CatToy < ApplicationRecord
  belongs_to :cat
  belongs_to :toy
end
