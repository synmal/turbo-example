class Todos::TodoItemsController < ApplicationController
  before_action :set_todo
  before_action :set_todo_item, only: %i( edit update destroy )

  private
    def todo_item_params
      params.require(:todo_items).permit(:description)
    end

    def set_todo
      @todo = Todo.find(params[:todo_id])
    end

    def set_todo_item
      @todo_item = @todo.todo_items.find(params[:id])
    end
end
