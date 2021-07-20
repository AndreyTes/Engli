class AddCategoryToPhrase < ActiveRecord::Migration[6.1]
  def change
    add_column :phrases, :category, :integer
  end
end
