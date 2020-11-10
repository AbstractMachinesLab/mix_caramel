defmodule MyTasksTest do
  use ExUnit.Case
  doctest MyTasks

  test "greets the world" do
    assert MyTasks.hello() == :world
  end
end
