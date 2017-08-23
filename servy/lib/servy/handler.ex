defmodule Servy.Handler do
  @moduledoc "Handles HTTP requests."

  alias Servy.Conv

  # mix always runs from the root project directory
  @pages_path Path.expand("pages", File.cwd!)

  # import *all* functions into current namespace
  # import Servy.Plugins

  # import particular functions of a certain arity
  import Servy.FileHandler, only: [handle_file: 2]
  import Servy.Parser, only: [parse: 1]
  import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1, emojify: 1]


  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> emojify
    |> format_response
  end

  def route(%Conv{ method: "GET", path: "/about" } = conv) do
    @pages_path
    |> Path.join("about.html")
    |> File.read
    |> handle_file(conv)
  end

  def route(%Conv{ method: "GET", path: "/wildthings" } = conv) do
    %{ conv | status: 200, resp_body: "Bears, Lions, Tigers" }
  end

  def route(%Conv{ method: "GET", path: "/bears" } = conv) do
    %{ conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }
  end

  def route(%Conv{ method: "POST", path: "/bears" } = conv) do
    %{ conv | status: 201, resp_body: "Created a #{conv.params["type"]} bear named #{conv.params["name"]}!" }
  end

  def route(%Conv{ method: "GET", path: "/bears/new"} = conv) do
    @pages_path
    |> Path.join("form.html")
    |> File.read
    |> handle_file(conv)
  end

  def route(%Conv{ method: "GET", path: "/bears/" <> id } = conv) do
    %{ conv | status: 200, resp_body: "Bear #{id}" }
  end

  def route(%Conv{ method: "DELETE", path: "/bears/" <> id } = conv) do
    %{ conv | status: 200, resp_body: "Bear #{id} was DAELETED" }
  end

  def route(%Conv{ method: "GET", path: "/pages/" <> page } = conv) do
    Path.expand("../../pages", __DIR__)
    |> Path.join("#{page}.html")
    |> File.read
    |> handle_file(conv)
  end

  def route(%Conv{ path: path } = conv) do
    %{ conv | status: 404, resp_body: "No #{path} here." }
  end

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Length: #{byte_size(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end


# request = """
# GET /wildthings HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# response = Servy.Handler.handle(request)
# IO.puts response


# request = """
# GET /bears HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# response = Servy.Handler.handle(request)
# IO.puts response


# request = """
# GET /unknown HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# response = Servy.Handler.handle(request)
# IO.puts response


# request = """
# GET /bears/123 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# response = Servy.Handler.handle(request)
# IO.puts response


# request = """
# GET /bears?id=1 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# response = Servy.Handler.handle(request)
# IO.puts response

# request = """
# DELETE /bears/123 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# response = Servy.Handler.handle(request)
# IO.puts response


# request = """
# GET /wildlife HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """
# response = Servy.Handler.handle(request)
# IO.puts response

request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Servy.Handler.handle(request)
IO.puts response


request = """
GET /bears/new HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""
response = Servy.Handler.handle(request)
IO.puts response


request = """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""
response = Servy.Handler.handle(request)
IO.puts response
