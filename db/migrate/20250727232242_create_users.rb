class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :api_key

      t.timestamps
    end
    add_index :users, :api_key
  end
end
