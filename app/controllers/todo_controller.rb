class TodoController < ApplicationController
  def show
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
