defmodule FoodServiceWeb.CommentView do
  use FoodServiceWeb, :view
  alias FoodServiceWeb.CommentView

  def render("index.json", %{comments: comments}) do
    %{
      data: render_many(comments, CommentView, "comment.json")
    }
  end

  def render("comment.json", %{comment: comment}) do
    %{
      id: comment.id,
      info: comment.info
    }
  end
end