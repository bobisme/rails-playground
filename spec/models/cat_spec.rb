require 'rails_helper'

# class Cat < ApplicationRecord
#   has_many :cat_toy
#   has_many :toys, through: :cat_toy, dependent: :destroy
# end
#
# class Toy < ApplicationRecord
# end
#
# class CatToy < ApplicationRecord
#   belongs_to :cat
#   belongs_to :toy
# end

describe 'Cat' do
  it 'can be created' do
    Cat.create!(name: 'Ezzie')
  end

  describe 'toys' do
    let(:cat) { Cat.create!(name: 'Ezzie') }
    let(:toys) { (1..3).map { |x| Toy.create!(name: "Toy #{x}") } }

    it 'can have many toys' do
      cat.toys = toys[0..1]
      cat.reload
      expect(cat.toys).to eq [toys[0], toys[1]]
    end

    it 'creates a new CatToy whenever it gets a toy' do
      cat.toys = toys[0..1]
      expect(CatToy.count).to eq 2
    end

    it 'deletes relevant CatToys when toys are removed' do
      cat.toys = toys[0..1]
      cat.toys = []
      expect(CatToy.count).to eq 0
    end

    it 'does not delete the toys themselves' do
      cat.toys = toys[0..1]
      cat.toys = []
      expect(Toy.count).to eq 3
    end
  end
end
