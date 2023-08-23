class Create < ActiveRecord::Migration[7.0]
  def change
    create_table :application_events do |t|
      t.integer :status, null: false
      t.references :application, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
