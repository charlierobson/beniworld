

class room_hatshop extends roomActor
{
  characterActor _shopkeeper;

  public room_hatshop()
  {
    super();

    _name = "hatshop";
    _carpet = new fancyCarpet("data/hatshop.png");

    _shopkeeper = (characterActor)addOccupant(new characterActor(_name));
    _shopkeeper._z = 110;

    _doors.add(new trigger(0, 400, 75, "changeroom plaza"));
    _furniture.add(new furnitureActor("data/counter.svg", 400, 350, 120));

    String[] itemNames = 
    {
      "data/hat_red.svg", "data/hat_green.svg",
      "data/hat_beany.svg", "data/hat_colander.svg",
      "data/hat_red.svg", "data/hat_green.svg",
      "data/hat_beany.svg", "data/hat_colander.svg",
    };

    int x = 80;
    for (String itemName : itemNames)
    {
      _furniture.add(new furnitureActor(itemName, x, 180));
      x += 75;
      if (x > 375 && x < 395) x += 110;
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

