class item
{
  public String _name;
  public String _description;
  public String _whenClicked;

  public int _price;

  public actor _actor;

  PImage _image;

  public item(String name, int price, String description, String whenClicked)
  {
    _name = name;
    _price = price;
    _description = description;
    _whenClicked = whenClicked;
  }

  public String imageName()
  {
    return "data/"+_name+".svg";
  }
}


ArrayList<item> _items;
PShape _boughtItem;

class hatShopKeeperActor extends characterActor
{
  public hatShopKeeperActor(String name)
  {
    super(name);
  }

  void executeAction(String[] actionTokens)
  {
    if (actionTokens[0].equals("click"))
    {
      int x = Integer.parseInt(actionTokens[1]);
      int y = Integer.parseInt(actionTokens[2]);
      if (dist(_x, _y, x, y) < 25)
      {
        beni._hat = _boughtItem;
      }
    } else if (actionTokens[0].equals("buy"))
    {
      String itemName = actionTokens[1];
      for (item it : _items)
      {
        if (it._name.equals(itemName))
        {
          say("Ah yes. " + it._description + ". That will be " + it._price + ".");
          _boughtItem = it._actor._sprite;
        }
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

    _items = new ArrayList<item>();
    _items.add(new item("hat_red", 100, "A lovely red cap", "buy hat_red"));
    _items.add(new item("hat_green", 100, "A stylish green Tam-O-Shanter", "buy hat_green"));
    _items.add(new item("hat_beany", 250, "The Beany. One of a kind", "buy hat_beany"));
    _items.add(new item("hat_derp", 500, "Derpy glasses. A brilliant disguise", "buy hat_derp"));
    _items.add(new item("hat_top", 750, "A classy top hat. Classy.", "buy hat_top"));
    _items.add(new item("hat_colander", 1001, "It looks like a colander... Now how did that get up there?", "buy hat_colander"));
    _items.add(new item("hat_fish", 1250, "Fish hats, fish hats, rolly poll... oh, sorry, that's my dinner.", "buy hat_fish"));
    _items.add(new item("hat_crown", 2000, "You'll be the envy of your country", "buy hat_crown"));

    _name = "hatshop";
    _carpet = new fancyCarpet("data/hatshop.png");

    _shopkeeper = (characterActor)addOccupant(new hatShopKeeperActor(_name));
    _shopkeeper._z = 110;
    _shopkeeper._eyesFollowYou = true;

    _doors.add(new trigger(0, 400, 75, "changeroom plaza"));
  }

  void whenEnteredFrom(String lastRoomName)
  {
    if (lastRoomName.equals("plaza"))
    {
      broadcast("movebeni 100,400");
      _shopkeeper.say("Hi. Would you like to buy a lovely hat?|Click a hat then click on me to buy it.");

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
      for (item it : _items)
      {
        // there are 4 items per shelf. shelfPosition/4 gives us the shelf number,
        // shelfPosition%4 gives us the position upon a particular shelf.
        int shelfNumber = shelfPosition / 4;
        int shelfSlot = shelfPosition % 4;

        int itemX = shelfStart[shelfNumber] + shelfSlot * 80;

        it._actor = new itemActor(it.imageName(), itemX, 180, it._description, it._price, it._whenClicked);

        _furniture.add(it._actor);
        _furniture.add(new labelActor(str(it._price), itemX, 185));

        ++shelfPosition;
      }
    }
  }

  void keyPressed(int key, int keyCode)
  {
    super.keyPressed(key, keyCode);
    if (beni._y < 380) beni._y = 380;
  }
}

