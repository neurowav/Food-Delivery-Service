defmodule FoodService.Images do
  @moduledoc """
  Type that Arc.Ecto needs for storing documents
  """

  use Arc.Definition
  use Arc.Ecto.Definition

  # типы обработанных изображений
  @versions [:resized, :preview, :tiny]

  def transform(:resized, _) do
    {:convert, "-resize 1000x1000\> -format png", :png}
  end

  def transform(:preview, _) do
    {:convert, "-thumbnail 1000x1000\> -format png", :png}
  end

  def transform(:tiny, _) do
    {:convert, "-thumbnail 20x20^ -format png", :png}
  end

  def filename(version, {file, _scope}) do
    "#{file.file_name}_#{version}"
  end

  def __storage, do: Arc.Storage.Local

  # NOTE: OMG
  def full_urls(args) do
    {document, _kyc} = args
    full_urls(args, document)
  end

  def full_urls(_args, nil) do
    nil
  end

  def full_urls(args, _document),
    do:
      args
      |> __MODULE__.urls()
      |> Enum.map(fn {k, v} -> {k, FoodServiceWeb.Endpoint.url() <> v} end)
      |> Map.new()
end
