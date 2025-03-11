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
    @todo = Todo.new
    print @todo
    # @todo.save
  end
  def create
  # @todo = Todo.new(title: params[:title], done: params[:done] || false)
  @todo = Todo.new
        @product = Product.new(product_params)
    print @todo
    if @todo.save
      redirect_to root_path, notice: "Todo was successfully created." # 保存成功時
    else
      render :new  # 保存失敗時（バリデーションエラーなど）はnewテンプレートを再表示
    end
  end
  def edit
    @todo = Todo.find(set_todo_params)
  end

  def update
    @todo = Todo.find(set_todo_params)
    if @todo.update(todo_params)
      redirect_to @todo, notice: "Todo was successfully updated." # 更新成功時
    else
      render :edit  # 更新失敗時（バリデーションエラーなど）はeditテンプレートを再表示
    end
  end
  private def todo_params
    params.require(:todo).permit(:title, :done) # ストロングパラメーター
  end
   def set_todo_params
     @todo = Todo.find(params[:id])
   end
  
end
