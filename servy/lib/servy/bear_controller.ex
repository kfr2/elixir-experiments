defmodule Servy.BearController do
  alias Servy.WildThings
  alias Servy.Bear
  alias Servy.BearView


  def index(conv) do
    bears =
      WildThings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name(&1, &2))
    %{ conv | status: 200, resp_body: BearView.index(bears) }
  end

  def show(conv, %{"id" => id}) do
    bear = WildThings.get_bear(id)
    %{ conv | status: 200, resp_body: BearView.show(bear) }
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{ conv | status: 201, resp_body: "Created a #{type} bear named #{name}!" }
  end

  def destroy(conv, %{"id" => id}) do
    bear = WildThings.get_bear(id)
    %{ conv | status: 200, resp_body: "#{bear.name} (#{bear.id}) was DAELETED" }
  end
end
