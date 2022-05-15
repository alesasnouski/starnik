defmodule Starnik.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(Starnik.Schema.WordFields)

  def dataloader do
    source = Dataloader.Ecto.new(Repo)

    Dataloader.new()
    |> Dataloader.add_source(Repo, source)
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end

  def middleware(middleware, _flds, _objs) do
    middleware
  end

  query do
    import_fields(:word_queries)
  end
end
