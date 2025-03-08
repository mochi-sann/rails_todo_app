class TodoController < ApplicationController
  def show
    @todo = Todo.find(params[:id])
  end

  def create
  end

  def edit
  end

  def destroy
  end
  def index
    @todo = Todo.all
  end
end
