defmodule CrawlWeb.PageController do
  use CrawlWeb, :controller

  def index(conn, _params) do
    url = "https://shopee.vn/api/v4/search/search_items?by=pop&entry_point=ShopBySearch&limit=30&match_id=88201679&newest=0&order=desc&page_type=shop&scenario=PAGE_OTHERS&version=2"
    {:ok, response} = HTTPoison.get url
    {:ok, contribs} = Poison.decode(Map.get(response, :body))
    items = Map.get(contribs, "items")
    |> Enum.map(fn contrib -> Map.get(contrib, "item_basic") end) 
    |> Enum.map(fn contrib -> Map.take(contrib, ["image", "name", "price", "discount"]) end)
    IO.inspect(items)
    render(conn, "index.html", data: items)
  end
end
