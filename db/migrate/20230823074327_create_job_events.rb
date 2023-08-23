class CreateJobEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :job_events do |t|
      t.integer :status, null: false, default: 0
      t.references :job, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
