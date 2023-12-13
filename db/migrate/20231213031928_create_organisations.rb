# frozen_string_literal: true

class CreateOrganisations < ActiveRecord::Migration[7.1]
  def change
    create_table :organisations, id: :uuid do |t|
      t.string :org_name, null: false

      t.timestamps
    end
  end
end
