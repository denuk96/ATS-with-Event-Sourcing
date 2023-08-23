class AddMetricsToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :status, :integer, default: 0, null: false
    add_column :jobs, :hired, :integer, default: 0, null: false
    add_column :jobs, :rejected, :integer, default: 0, null: false
    add_column :jobs, :ongoing, :integer, default: 0, null: false
  end
end
