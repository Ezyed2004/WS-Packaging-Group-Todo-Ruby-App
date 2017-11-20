class AddTaskStateDueDateToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :state, :string, default: "pending"
    add_column :tasks, :due_date, :string
  end
end
