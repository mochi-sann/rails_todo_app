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
    @todo = Todo.all
  end
  def show
    @todo = Todo.find(params[:id])
  end
  def new
    @todo = Todo.new(title: params[:title], done: false)
    # @todo.save
    # redirect_to todo_path(@todo)
  end
end
