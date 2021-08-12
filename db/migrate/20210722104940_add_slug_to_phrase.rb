class AddSlugToPhrase < ActiveRecord::Migration[6.1]
  def change
    add_column :phrases, :slug, :string
    add_index :phrases, :slug, unique: true
  end
end
