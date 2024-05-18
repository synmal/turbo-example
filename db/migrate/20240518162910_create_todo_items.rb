class CreateTodoItems < ActiveRecord::Migration[7.1]
  def change
    create_table :todo_items do |t|
      t.string :description, null: false
      t.references :todo

      t.timestamps
    end
  end
end
