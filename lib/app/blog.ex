defmodule App.Blog do
  @moduledoc """
  Blog posts
  """

  alias App.Blog

  use NimblePublisher,
    build: Blog.Post,
    parser: Blog.Parser,
    from: Application.app_dir(:app, "priv/blog/*.md"),
    as: :posts

  defmodule NotFoundError do
    defexception [:message, plug_status: 404]
  end

  def all, do: @posts

  def get!(id) do
    Enum.find(all(), &(&1.id == id)) ||
      raise NotFoundError, "post with id=#{id} not found"
  end
end
