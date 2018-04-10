class CreateCatToys < ActiveRecord::Migration[5.0]
  def change
    create_table :cat_toys do |t|
      t.references :cat, foreign_key: true
      t.references :toy, foreign_key: true

      t.timestamps
    end
  end
end
