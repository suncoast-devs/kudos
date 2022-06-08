class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :emoji
      t.integer :daily_budget

      t.timestamps
    end
  end
end
