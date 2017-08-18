defmodule Servy.Parser do
  @moduledoc "Parse a request into its constituent parts."

  # alias Servy.Conv, as: Conv
  # The above is very common so this form can be used:
  alias Servy.Conv

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")

    %Conv{
      method: method,
      path: path
    }
  end
end
