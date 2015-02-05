defmodule Entice.Web.GroupChannelTest do
  use ExUnit.Case
  use Entice.Area
  #use Entice.Area.Attributes
  alias Entice.Web.GroupChannel
  alias Entice.Web.Account
  alias Entice.Web.Character
  alias Entice.Web.Clients
  alias Entice.Web.Players
  #alias Entice.Web.Groups
  #alias Entice.Area.Entity
  #alias Phoenix.PubSub
  alias Phoenix.Socket


  # TODO: dont rely on shared maps in tests, it fucks up the expected values


  test "join and get a group assigned" do
    socket = %Socket{pid: self, router: Entice.Web.Router}
    acc = %Account{characters: [%Character{name: "Some Char"}]}
    {:ok, cid} = Clients.add(acc)
    {:ok, eid} = Players.prepare_new_player(RandomArenas, socket, acc.characters |> hd)
    {:ok, tid} = Clients.create_token(cid, :player, %{area: RandomArenas, entity_id: eid, char: acc.characters |> hd})

    GroupChannel.join(
      "group:random_arenas",
      %{"client_id" => cid,
        "access_token" => tid},
      socket)

    assert_receive {:socket_reply, %Phoenix.Socket.Message{
      topic: nil,
      event: "join:ok",
      payload: %{
        group: _
      }}}
  end
end