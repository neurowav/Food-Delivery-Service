defmodule FoodService.Images do
  @moduledoc """
  Type that Arc.Ecto needs for storing documents
  """

  use Arc.Definition
  use Arc.Ecto.Definition

  # типы обработанных изображений
  @versions [:resized]

  def transform(:resized, _) do
    {:convert, "-resize 1000x1000\> -format png", :png}
  end

  def filename(version, {file, _scope}) do
    "#{file.file_name}_#{version}"
  end


  def __storage(:test), do: Arc.Storage.Local
  def __storage(:dev), do: Arc.Storage.Local
  def __storage(:prod), do: Arc.Storage.S3

  def __storage do
    __storage(Mix.env())
  end

  # NOTE: OMG
  def full_urls(args) do
    {document, _kyc} = args
    full_urls(args, document)
  end

  def full_urls(_args, nil) do
    nil
  end

  def full_urls(args, _document) do
    full_urls(args, _document, Mix.env())
  end

  def full_urls(args, _document, :test),
    do:
      args
      |> __MODULE__.urls()
      |> Enum.map(fn {k, v} -> {k, FoodServiceWeb.Endpoint.url() <> v} end)
      |> Map.new()

  def full_urls(args, _document, :dev),
    do:
      args
      |> __MODULE__.urls()
      |> Enum.map(fn {k, v} -> {k, FoodServiceWeb.Endpoint.url() <> v} end)
      |> Map.new()

  def full_urls(args, _document, :prod), do: __MODULE__.urls(args)
end
