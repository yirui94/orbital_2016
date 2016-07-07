class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.text :introduction
      t.string :website
      t.string :country
      t.string :medium
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :user_details, [:user_id, :country, :medium]
  end
end
