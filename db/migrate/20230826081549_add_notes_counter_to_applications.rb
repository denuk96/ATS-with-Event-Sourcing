class AddNotesCounterToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :notes_count, :integer, default: 0, null: false
  end
end
