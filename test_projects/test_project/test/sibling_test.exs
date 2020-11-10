defmodule SiblingTest do
  use ExUnit.Case
  doctest Sibling

  test "greets the world" do
    assert Sibling.hello() == :world
  end
end
