defmodule PoucetTest do
  use ExUnit.Case
  doctest Poucet

  @doc """
  Those test need an alive connection
  """
  test "greets the world" do
    assert Poucet.final_location("https://t.co/2m6SRbn6or") == {:ok, "https://www.eurogamer.net/articles/2019-11-04-londons-pokemon-center-is-running-out-of-its-exclusive-top-hat-pikachus"}
  end
end
