class TodoController < ApplicationController
  include Authentication
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
    @todos = if authenticated?
      Current.session.user.todos
    else
      Todo.all
    end
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
    @todo = Current.session.user.todos.build(todo_params)
    # @todo = Todo.new(title: params[:title], done: params[:done] || false)
    if @todo.save
      redirect_to root_path, notice: "Todo created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @todo = Todo.find(params[:id])
    @todo = build_todo(params)
  end

  def update
    @todo = Todo.find(params[:id])
    @todo = build_todo(params)
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
    params.require(:todo).permit(:title, :done, :featured_image) # ストロングパラメーター
    # params.require(:todo).permit(:title, :done) # ストロングパラメーター
  end

  def set_todo_params
    @todo = Todo.find(params[:id])
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
