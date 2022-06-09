class CreatePersonas < ActiveRecord::Migration[7.0]
  def change
    create_table :personas do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :platform
      t.string :uid
      t.string :name

      t.timestamps
    end
  end
end
