class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :platform
      t.integer :status, default: 0, nil: false
      t.jsonb :data, default: {}, nil: false

      t.timestamps
    end
  end
end
