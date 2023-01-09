defmodule App.Blog.Post do
  @moduledoc """
  Blog post
  """

  @keys ~w{id title body date}a
  @enforce_keys @keys
  defstruct @keys

  def build(filename, attrs, body) do
    [year, month, day, id] =
      filename
      |> Path.rootname()
      |> Path.split()
      |> List.last()
      |> String.split("-", parts: 4)

    date = Date.from_iso8601!("#{year}-#{month}-#{day}")

    struct!(__MODULE__, Map.merge(attrs, %{
      id: id,
      body: body,
      date: date
    }))
  end
end
