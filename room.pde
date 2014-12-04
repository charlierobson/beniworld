import java.util.Collections;

class roomActor extends actor
{
  ArrayList<trigger> _doors;
  ArrayList<actor> _furniture;
  ArrayList<actor> _occupants;

  String _name;

  carpet _carpet;

  public roomActor()
  {
    super();

    _doors = new ArrayList<trigger>();
    _furniture = new ArrayList<actor>();
    _occupants = new ArrayList<actor>();
  }

  actor addOccupant(actor occupant)
  {
    _occupants.add(occupant);
    return occupant;
  }

  void draw()
  {
    if (_carpet != null)
    {
      _carpet.draw();
    }

    ArrayList<actor> sortedActors = new ArrayList<actor>();
    sortedActors.addAll(_furniture); //<>//
    sortedActors.addAll(_occupants);
    sortedActors.add(beni);
    Collections.sort(sortedActors);

    for (actor act : sortedActors)
    {
      act.draw();
    }
  }


  void update(int ticks)
  {
    super.update(ticks);
    
    for (actor occupant : _occupants)
    {
      occupant.update(ticks);
    }

    for (trigger door : _doors)
    {
      door.check(beni);
    }
  }

  // when a trigger or other interaction needs to inform objects to update their state
  // then this function will be called. all objects get all actions, 
  void executeAction(String[] actionTokens)
  {
    // only the current room gets to do a room change
    if (actionTokens[0].equals("changeroom") && currentRoom == this)
    {
      currentRoom = getRoom(actionTokens[1]);
      println(currentRoom._name);
      currentRoom.whenEnteredFrom(_name);
    }
  }

  // this will be called when a room is entered.
  // we are told the name of the room which was just exited.
  void whenEnteredFrom(String previousRoomName)
  {
  }



  void keyPressed(int key, int keyCode)
  {
    if (key == CODED)
    {
      if (keyCode == UP)
      {
        beni._y -= 20;
      } else if (keyCode == DOWN)
      {
        beni._y += 20;
      } else if (keyCode == LEFT)
      {
        beni._x -= 20;
      } else if (keyCode == RIGHT)
      {
        beni._x += 20;
      }

      if (beni._x < 0) beni._x = 0;
      else if (beni._x > sceneWidth) beni._x = sceneWidth;
      if (beni._y < 0) beni._y = 0;
      else if (beni._y > sceneHeight) beni._y = sceneHeight;
    }
  }

  void keyReleased(int key, int keyCode)
  {
  }
}

