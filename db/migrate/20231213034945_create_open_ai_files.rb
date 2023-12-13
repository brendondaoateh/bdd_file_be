class CreateOpenAiFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :open_ai_files, id: :uuid do |t|
      t.belongs_to :member, type: :uuid, null: false, foreign_key: true

      t.string :file_id, null: false
      t.bigint :bytes, null: false
      t.timestamp :remotely_created_at, null: false
      t.string :filename, null: false
      t.string :object, null: false
      t.string :purpose, null: false

      t.timestamps
    end
  end
end
