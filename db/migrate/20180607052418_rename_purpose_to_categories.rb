class RenamePurposeToCategories < ActiveRecord::Migration[5.2]
  def change
    rename_table :purposes, :categories
  end
end
