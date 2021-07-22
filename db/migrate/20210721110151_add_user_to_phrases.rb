class AddUserToPhrases < ActiveRecord::Migration[6.1]
  def change
    add_reference :phrases, :user, foreign_key: true, index: true
  end
end
