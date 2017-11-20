class ChangeStateToStatusInTasks < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :state, :status
  end
end
