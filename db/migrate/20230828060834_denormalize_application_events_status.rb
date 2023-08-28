class DenormalizeApplicationEventsStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :status, :integer, null: false, default: 0
  end
end
