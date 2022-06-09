class CreateConferrals < ActiveRecord::Migration[7.0]
  def change
    create_table :conferrals do |t|
      t.references :giver, null: false, foreign_key: { to_table: :personas }
      t.references :receiver, null: false, foreign_key: { to_table: :personas }

      t.timestamps
    end
  end
end
