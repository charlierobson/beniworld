import java.util.Collections; // for sort

abstract class clickTarget
{
  String _clickedAction;

  abstract boolean isClicked(int x, int y);
}

class rectangleClickTarget extends clickTarget
{
  int _x, _y, _w, _h;
  boolean isClicked(int x, int y)
  {
    return x >= _x && x <= _x + _w && y >= _y && y <= _y + _h;
  }
}

class circularClickTarget extends clickTarget
{
  int _x, _y, _r;

  circularClickTarget(int x, int y, int r, String clickedAction)
  {
    _x = x;
    _y = y;
    _r = r;
    _clickedAction = clickedAction;
  }

  boolean isClicked(int x, int y)
  {
    return dist(x, y, _x, _y) < _r;
  }
}


class roomActor extends actor
{
  ArrayList<trigger> _doors;
  ArrayList<actor> _furniture;
  ArrayList<actor> _occupants;

  ArrayList<clickTarget> _hitBoxes;
  
  ArrayList<actor> _sortedActors;

  String _name;

  carpet _carpet;

  public roomActor()
  {
    super();

    _doors = new ArrayList<trigger>();
    _furniture = new ArrayList<actor>();
    _occupants = new ArrayList<actor>();
    _hitBoxes = new ArrayList<clickTarget>();
    _sortedActors = new ArrayList<actor>();
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

    _hitBoxes.clear();
    for (actor act : _sortedActors)
    {
      act.draw();
      if (act._hitBox != null)
      {
        _hitBoxes.add(act._hitBox);
      }
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

    // sort all of the objects by their _z coordinate.
    // when it comes time to draw them they will be drawn from back to front
    _sortedActors.clear();
    _sortedActors.addAll(_furniture);
    _sortedActors.addAll(_occupants);
    _sortedActors.add(beni);
    Collections.sort(_sortedActors);
  }

  // when a trigger or other interaction needs to inform objects to update their state
  // then this function will be called. all objects get all actions, 
  void executeAction(String[] actionTokens)
  {
    // only the current room gets to do a room change
    if (actionTokens[0].equals("changeroom") && currentRoom == this)
    {
      broadcast("leaveroom " + currentRoom._name);

      currentRoom = getRoom(actionTokens[1]);
      println(currentRoom._name);
      currentRoom.whenEnteredFrom(_name);
      return;
    }

    if (actionTokens[0].equals("click"))
    {
      int x = Integer.parseInt(actionTokens[1]);
      int y = Integer.parseInt(actionTokens[2]);
      for(clickTarget hitBox : _hitBoxes)
      {
        if (hitBox.isClicked(x, y))
        {
          broadcast(hitBox._clickedAction);
          return;
        }
      }
    }

    for (int i = _sortedActors.size () - 1; i != -1; --i)
    {
      _sortedActors.get(i).executeAction(actionTokens);
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

