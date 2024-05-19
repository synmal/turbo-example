class Todos::TodoItemsController < ApplicationController
  before_action :set_todo
  # before_action :set_todo_item, only: %i( edit update destroy )

  def new
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append(
            "todo_#{@todo.id}_todo_items",
            partial: 'todos/todo_items/new',
            locals: { todo: @todo }
          )
        ]
      end
    end
  end

  def create
    @item = @todo.todo_items.new(todo_item_params)

    if @item.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append(
              "todo_#{@todo.id}_todo_items",
              partial: 'todos/todo_items/todo_item',
              locals: { item: @item }
            ),
            turbo_stream.remove("new_todo_#{@todo.id}_item")
          ]
        end
      end
    end
  end

  private
    def todo_item_params
      params.require(:todo_item).permit(:description)
    end

    def set_todo
      @todo = Todo.find(params[:todo_id])
    end

    def set_todo_item
      @todo_item = @todo.todo_items.find(params[:id])
    end
end