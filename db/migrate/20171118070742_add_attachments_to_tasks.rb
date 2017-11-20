class AddAttachmentsToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :attachments, :string
  end
end
