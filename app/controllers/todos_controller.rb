class TodosController < ApplicationController
  def new
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
            )
          ]
        end
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def todo_params
      params.require(:todo).permit(:description)
    end
end
