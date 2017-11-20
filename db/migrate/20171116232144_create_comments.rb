class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :name
      t.text :body
      t.references :task, :user, polymorphic: true

      t.timestamps
    end
  end
end