class TodoController < ApplicationController
  # def edit
  #   @todo = Todo.find(params[:id])
  # end
  #
  # def destroy
  #   @todo = Todo.find(params[:id])
  #   @todo.destroy
  #   redirect_to todo_index_path
  # end
  def index
    @todos = Todo.all
  end
  def show
    @todo = Todo.find(params[:id])
  end
  def new
    @todo = Todo.new(title: params[:title], done: false)
    print @todo
    # @todo.save
  end
  def create
  @todo = Todo.new(title: params[:title], done: false)
    @todo = Todo.new(todo_params)
    print @todo
    if @todo.save
      redirect_to root_path, notice: "Todo was successfully created." # 保存成功時
    else
      render :new  # 保存失敗時（バリデーションエラーなど）はnewテンプレートを再表示
    end
  end
  private def todo_params
    params.require(:todo).permit(:title) # ストロングパラメーター
  end
end
