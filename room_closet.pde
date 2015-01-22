class room_closet extends roomActor
{
  ArrayList<String> _purchasedHats;

  public room_closet()
  {
    super();
    _name= "closet";
    _carpet = new fancyCarpet("data/closet.png");

    _purchasedHats = new ArrayList<String>();

    _doors.add(new trigger(400, 600, 75, "changeroom home"));
  }

  void executeAction(String[] actionTokens)
  {
    if (actionTokens[0].equals("buy"))
    {
      println(actionTokens[0]);
      println(actionTokens[1]);

      String itemName = actionTokens[1];
      _purchasedHats.add(itemName);
    } else
    {
      super.executeAction(actionTokens);
    }
  }

  void whenEnteredFrom(String lastRoomName)
  {
    if (lastRoomName.equals("home"))
    {
      broadcast("movebeni 400,500");

      _furniture.clear();

      // there are 2 shelves. this contains the starting X coordinates for them.
      //
      //         index->   [0]  [1]
      int[] shelfStart = { 
        80, 400+80
      };

      // item index [0..num items-1]
      int shelfPosition = 0;
      for (String hatName : _purchasedHats)
      {
        if (!hatName.equals(beni._hatName))
        {
          item it = hats.findItemByName(hatName);

          // there are 4 items per shelf. shelfPosition/4 gives us the shelf number,
          // shelfPosition%4 gives us the position upon a particular shelf.
          int shelfNumber = shelfPosition / 4;
          int shelfSlot = shelfPosition % 4;

          int itemX = shelfStart[shelfNumber] + shelfSlot * 80;

          it._actor = new itemActor(it.imageName(), itemX, 180, it._description, it._price, it._whenClicked);

          _furniture.add(it._actor);
        }
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

