class CreateCategoryDescriptions < ActiveRecord::Migration[5.2]
  def up
    create_table :category_descriptions do |t|
      t.string :description
      t.references :trip, foreign_key: true
      t.references :category, foreign_key: true
    end
  end

  def down 
    drop_table :category_descriptions
  end
end
