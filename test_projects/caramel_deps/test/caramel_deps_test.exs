defmodule CaramelDepsTest do
  use ExUnit.Case
  doctest CaramelDeps

  test "greets the world" do
    assert CaramelDeps.hello() == :world
  end

  test "caramel deps" do
    :caradeps_a.aa("hello")
    :caradeps_b.bb("hello")
    :caradeps_c.cc("hello")
  end
end
