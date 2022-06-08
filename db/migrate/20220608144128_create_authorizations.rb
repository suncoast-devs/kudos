class CreateAuthorizations < ActiveRecord::Migration[7.0]
  def change
    create_table :authorizations do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :platform
      t.string :uid
      t.jsonb :data
      t.string :access_token
      t.string :refresh_token
      t.timestamp :expires_at

      t.timestamps

      t.index %i[platform uid], unique: true
    end
  end
end
