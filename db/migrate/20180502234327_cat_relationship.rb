class CatRelationship < ActiveRecord::Migration[5.0]
  def change
    create_table :cat_relationships do |t|
      t.references :giver, references: :cat, foreign_key: true
      t.references :taker, references: :cat, foreign_key: true
    end
  end
end
