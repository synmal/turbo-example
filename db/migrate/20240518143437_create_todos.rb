class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos, id: :uuid do |t|
      t.string :description

      t.timestamps
    end
  end
end
