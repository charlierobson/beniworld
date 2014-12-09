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
    }
    else if (actionTokens[0].equals("buy"))
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

    _name = "hatshop";
    _carpet = new fancyCarpet("data/hatshop.png");

    _shopkeeper = (characterActor)addOccupant(new hatShopKeeperActor(_name));
    _shopkeeper._z = 110;
    _shopkeeper._eyesFollowYou = true;

    _doors.add(new trigger(0, 400, 75, "changeroom plaza"));
    _furniture.add(new furnitureActor("data/counter.svg", 400, 350, 120));

    int x = 80;
    for (item it : _items)
    {
      it._actor = new itemActor(it.imageName(), x, 180, it._description, it._price, it._whenClicked);
      _furniture.add(it._actor);
      _furniture.add(new labelActor(str(it._price), x, 185));

      x += 80;
    }
  }

  void whenEnteredFrom(String lastRoomName)
  {
    if (lastRoomName.equals("plaza"))
    {
      broadcast("movebeni 100,400");
      _shopkeeper.say("Hi. Would you like to buy a lovely hat?|Click a hat then click on me to buy it.");
    }
  }

  void keyPressed(int key, int keyCode)
  {
    super.keyPressed(key, keyCode);
    if (beni._y < 380) beni._y = 380;
  }
}

