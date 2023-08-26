class CreateApplicationRelatedNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :application_notes do |t|
      t.string :content, null: false
      t.references :application, foreign_key: true, index: true

      t.timestamps
    end
  end
end
