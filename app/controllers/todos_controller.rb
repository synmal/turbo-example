class TodosController < ApplicationController
  before_action :set_todo, only: %i( edit update destroy )

  def index
    sleep 1
    respond_to do |format|
      todos = Todo.all.order(created_at: :desc)

      # todos-container
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
    respond_to do |f|
      f.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(
            "todo_#{@todo.id}",
            partial: 'todos/edit',
            locals: { todo: @todo }
          )
        ]
      end
    end
  end

  def update
    if @todo.update(todo_params)
      respond_to do |f|
        f.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "todo_#{@todo.id}",
              partial: 'todos/todo',
              locals: { todo: @todo }
            )
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
      params.require(:todo).permit(:description)
    end

    def set_todo
      @todo = Todo.find(params[:id])
    end
end
