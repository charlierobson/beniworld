class item
{
  public String _name;
  public int _price;
  PImage _image;

  public item(String name, int price)
  {
    _name = name;
    _price = price;
  }

  public String imageName()
  {
    return "data/"+_name+".svg";
  }
}



class room_hatshop extends roomActor
{
  characterActor _shopkeeper;
  ArrayList<item> _items;

  public room_hatshop()
  {
    super();

    _items = new ArrayList<item>();
    _items.add(new item("hat_red", 15));
    _items.add(new item("hat_green", 15));
    _items.add(new item("hat_beany", 25));
    _items.add(new item("hat_derp", 150));

    _name = "hatshop";
    _carpet = new fancyCarpet("data/hatshop.png");

    _shopkeeper = (characterActor)addOccupant(new characterActor(_name));
    _shopkeeper._z = 110;
    _shopkeeper._eyesFollowYou = true;

    _doors.add(new trigger(0, 400, 75, "changeroom plaza"));
    _furniture.add(new furnitureActor("data/counter.svg", 400, 350, 120));

    int x = 80;
    for (item it : _items)
    {
      _furniture.add(new furnitureActor(it.imageName(), x, 180));
      _furniture.add(new labelActor(str(it._price), x, 185));

      x += 80;
    }
  }

  void whenEnteredFrom(String lastRoomName)
  {
    if (lastRoomName.equals("plaza"))
    {
      broadcast("movebeni 100,400");
      _shopkeeper.say("Hi. Would you like to buy a lovely hat?");
    }
  }

  void keyPressed(int key, int keyCode)
  {
    super.keyPressed(key, keyCode);
    if (beni._y < 380) beni._y = 380;
  }
}

