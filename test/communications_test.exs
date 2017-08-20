defmodule CommunicationsTest do
  use ExUnit.Case
  doctest Communications

  test "greets the world" do
    assert Communications.hello() == :world
  end
end
