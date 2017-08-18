defmodule Servy.Plugins do
  @moduledoc "Plugins to Servy!"

  require Logger

  alias Servy.Conv

  def rewrite_path_captures(conv, %{"thing" => thing, "id" => id}) do
    %{ conv | path: "/#{thing}/#{id}" }
  end

  def rewrite_path_captures(conv, nil), do: conv

  def rewrite_path(%{ path: "/wildlife"} = conv) do
    %{ conv | path: "/wildthings" }
  end

  def rewrite_path(%Conv{ path: path } = conv) do
    regex = ~r{\/(?<thing>\w+)\?id=(?<id>\d+)}
    captures = Regex.named_captures(regex, path)
    rewrite_path_captures(conv, captures)
  end

  def rewrite_path(%Conv{} = conv), do: conv


  def log(%Conv{} = conv), do: IO.inspect conv


  def track(%Conv{ status: 404, path: path } = conv) do
    Logger.info "Warning: #{path} is on the loose!"
    conv
  end

  def track(%Conv{} = conv), do: conv


  # def emojify(%{ status: 200 } = conv) do
  #   %{ conv | resp_body: "-> #{conv.resp_body} <-" }
  # end

  def emojify(conv) do
    conv
  end
end
