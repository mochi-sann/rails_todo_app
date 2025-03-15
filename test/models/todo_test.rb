require "test_helper"

class TodoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test("validates presence of title") do
    user = User.create!(email: "example_test@example.com", password: "password")
    todo = Todo.new(title: "Sample Todo", user_id: user.id)
    # done should be false by default
    assert_not todo.done
  end
end
