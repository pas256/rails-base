# frozen_string_literal: true

# Add a super simple user model with only a unique email address
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
