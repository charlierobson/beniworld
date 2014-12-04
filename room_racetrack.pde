

class room_racetrack extends roomActor
{
  characterActor _competitor;
  actor _raceWinner;

  int _raceXP;

  public room_racetrack()
  {
    super();

    _name = "racetrack";
    _carpet = new fancyCarpet("data/racetrack.png");

    _competitor = (characterActor)addOccupant(new characterActor("competitor"));

    _raceXP = 0;
  }


  void update(int ticks)
  {
    super.update(ticks);

    if (_raceWinner == null)
    {
      if (_competitor._x >= 700)
      {
        _raceWinner = _competitor;
        _competitor.say("I win! Better luck next time!", 4000);
      }
      if (beni._x >= 700)
      {
        _raceWinner = beni;
        _competitor.say("You win! I'll beat you next time!", 4000);
        ++_raceXP;
      }

      if (_raceWinner!= null)
      {
        _timer = 0;
      }
    }

    if (_competitor._timer > 400 && _raceWinner == null)
    {
      int speed = 15 + (_raceXP * 3);
      _competitor._x += speed;
      _competitor._timer -= 400;
    }

    if (_raceWinner != null && _timer > 4000)
    {
      broadcast("changeroom plaza");
    }
  }

  void whenEnteredFrom(String lastRoomName)
  {
    if (lastRoomName.equals("plaza"))
    {
      _raceWinner =null ;
      _competitor._x = 100;
      _competitor._y = 300;
      _competitor._timer = 0;
      if (_raceXP == 0)
      {
        _competitor.say ("Race You! Press space to run", 4000);
      } else if (_raceXP == 1)
      {
        _competitor.say ("Hello Again! Ready to be beaten?", 4000);
      } else
      {
        String[] wittySayings =
        {
          "Ha! You won't win this time!", 
          "Be sure to take breaks between racing! Or not."
        };
        _competitor.say (wittySayings[(int)random(wittySayings.length)], 4000);
      }
      broadcast("movebeni 50,315");
    }
  }

  void keyPressed(int key, int keyCode)
  {
  }

  void keyReleased(int key, int keyCode)
  {
    if (_raceWinner == null && key == ' ')
    {
      beni._x += 20;
    }
  }
}

