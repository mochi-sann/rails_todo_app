class TodoController < ApplicationController
  before_action :set_todo, only: %i[show edit update destroy]
  allow_unauthenticated_access only: %i[show index]

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
    # @todo = Todo.new(title: params[:title], done: params[:done] || false)
    @todo = build_todo(params)
    print @todo
    # @todo.save
  end

  def create
    @todo = build_todo(params)
    # @todo = Todo.new(title: params[:title], done: params[:done] || false)
    @todo = Todo.new(todo_params)
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

  def destroy
    # @todo = Todo.find(set_todo_params)

    if @todo.destroy
      redirect_to root_path, notice: "Todo was successfully destroyed." # 削除成功時
    end
  end

  private

  def build_todo(params)
    Todo.new(title: params[:title], done: params[:done] || false)
  end

  def todo_params
    params.require(:todo).permit(:title, :done) # ストロングパラメーター
    # params.require(:todo).permit(:title, :done) # ストロングパラメーター
  end

  def set_todo_params
    @todo = Todo.find(params[:id])
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
