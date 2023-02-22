class CreatePersonalities < ActiveRecord::Migration[6.0]
  def change
    create_table :personalities do |t|
      t.string :last_name,          null: false
      t.string :first_name,         null: false
      t.string :last_name_kana,     null: false
      t.string :first_name_kana,    null: false
      t.date :date_of_birth,        null: false
      t.references :user,           foreign_key: true, null: false
      t.timestamps
    end
  end
end
