
item _selectedItem;

class hatShopKeeperActor extends characterActor
{
  public hatShopKeeperActor(String name)
  {
    super(name);
    _selectedItem = null;
  }

  void executeAction(String[] actionTokens)
  {
    if (actionTokens[0].equals("select"))
    {
      String itemName = actionTokens[1];
      item it = hats.findItemByName(itemName);
      if (it != null)
      {
        say("Ah yes. " + it._description + ". That will be " + it._price + ".");
        _selectedItem = it;
      }
    } else if (actionTokens[0].equals("click") && _selectedItem != null)
    {
      int x = Integer.parseInt(actionTokens[1]);
      int y = Integer.parseInt(actionTokens[2]);
      if (dist(_x, _y, x, y) < 25)
      {
        beni._hat = _selectedItem._actor._sprite;
        _selectedItem._owned = true;

        broadcast("buy " + _selectedItem._name);
      }
    }
  }
}


class room_hatshop extends roomActor
{
  characterActor _shopkeeper;

  public room_hatshop()
  {
    super();

    _name = "hatshop";
    _carpet = new fancyCarpet("data/hatshop.png");

    _shopkeeper = (characterActor)addOccupant(new hatShopKeeperActor(_name));
    _shopkeeper._z = 110;
    _shopkeeper._eyesFollowYou = true;

    _doors.add(new trigger(0, 400, 75, "changeroom plaza"));
  }

  void buildShelves()
  {
    _furniture.clear();
    _furniture.add(new furnitureActor("data/counter.svg", 400, 350, 120));

    // there are 2 shelves. this contains the starting X coordinates for them.
    //
    //         index->   [0]  [1]
    int[] shelfStart = { 
      80, 400+80
    };

    // item index [0..num items-1]
    int shelfPosition = 0;
    for (item it : hats.items ())
    {
      // there are 4 items per shelf. shelfPosition/4 gives us the shelf number,
      // shelfPosition%4 gives us the position upon a particular shelf.
      int shelfNumber = shelfPosition / 4;
      int shelfSlot = shelfPosition % 4;

      int itemX = shelfStart[shelfNumber] + shelfSlot * 80;

      it._actor = new itemActor(it.imageName(), itemX, 180, it._description, it._price, it._whenClicked);

      if (!it._owned)
      {
        _furniture.add(it._actor);
        _furniture.add(new labelActor(str(it._price), itemX, 185));
      } else
      {
        _furniture.add(new labelActor("sold out", itemX, 185));
      }

      ++shelfPosition;
    }
  }

  void whenEnteredFrom(String lastRoomName)
  {
    //if (lastRoomName.equals("plaza"))
    {
      broadcast("movebeni 100,400");

      for (item it : hats.items ())
      {
        if (!it._owned)
        {
          _shopkeeper.say("Hi. Would you like to buy a lovely hat?|Click a hat then click on me to buy it.");
          break;
        }
      }


      buildShelves();
    }
  }

  void executeAction(String[] actionTokens)
  {
    if (actionTokens[0].equals("buy"))
    {
      buildShelves();
    } else
    {
      super.executeAction(actionTokens);
    }
  }

  void keyPressed(int key, int keyCode)
  {
    super.keyPressed(key, keyCode);
    if (beni._y < 380) beni._y = 380;
  }
}

