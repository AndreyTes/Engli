class CreateExamples < ActiveRecord::Migration[6.1]
  def change
    create_table :examples do |t|
      t.string :example
      t.references :user, foreign_key: true, index: true
      t.references :phrase, foreign_key: true, index: true

      t.timestamps
    end
  end
end
