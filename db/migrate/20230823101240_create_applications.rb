class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :candidate_name, null: false
      t.references :job, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
