class TodosController < ApplicationController
  def index
    # sleep 1
    respond_to do |format|
      todos = Todo.includes(:todo_items).all.order(created_at: :desc)

      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(
            "todos-container",
            partial: 'todos/todo',
            collection: todos,
            as: :todo
          )
        ]
      end
    end
  end

  def new
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.prepend(
            "todos-container",
            partial: 'todos/new'
          )
        ]
      end
    end
  end

  def create
    todo = Todo.new(todo_params)

    if todo.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend(
              "todos-container",
              partial: 'todos/todo',
              locals: { todo: todo }
            ),
            turbo_stream.remove("new_todo")
          ]
        end
      end
    end
  end

  def destroy
    @todo.destroy

    respond_to do |f|
      f.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove("todo_#{@todo.id}")
        ]
      end
    end
  end

  private
    def todo_params
      params.require(:todo).permit(todo_items_attributes: [:id, :description, :_destroy])
    end

    def set_todo
      @todo = Todo.find(params[:id])
    end
end
