class HomepageController < ApplicationController
  def show
    @todos = Todo.all.order(created_at: :desc)
    @text = params[:text]

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(
            "text-container",
            partial: 'homepage/text',
            locals: { text: @text }
          ),
          turbo_stream.update(
            "navbar",
            partial: 'shared/nav'
          ),
        ]
      end
    end
  end
end
