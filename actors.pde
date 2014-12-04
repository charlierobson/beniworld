class actor implements Comparable<actor>
{
  protected int _timer;

  protected int _x, _y, _z;

  public PShape _sprite;

  public actor()
  {
    _z = 100;
  }

  void draw()
  {
    fill(0);
    arc(_x, _y, 50, 50, 0, 2*PI, OPEN);
  }

  void update(int millis)
  {
    _timer += millis;
  }

  // enable comparisons on the sprite Z depth order
  int compareTo(actor p)
  {
    if (p._z < this._z) return 1;
    else if (p._z > this._z) return -1;
    else return 0;
  }
}





class characterActor extends actor
{
  PShape _eyes_open;
  PShape _eyes_blink;

  int _blinkRate;
  int _blinkTime;

  int _speechBubbleTime;
  String _speechBubbleText;

  public characterActor(String characterName)
  {
    super();

    _x = sceneWidth / 2;
    _y = sceneHeight / 2;

    _sprite = loadShape("data/"+characterName+"_body.svg");
    _eyes_open = loadShape("data/"+characterName+"_eyesopen.svg");
    _eyes_blink = loadShape("data/"+characterName+"_eyesblink.svg");

    _blinkRate = 3000 + (1000 - (int)random(2000));
    _blinkTime = 100;
  }

  public void update(int ticks)
  {
    super.update(ticks);

    _blinkTime -= ticks;

    if (_speechBubbleText != null)
    {
      _speechBubbleTime -= ticks;
      if (_speechBubbleTime < 0)
      {
        _speechBubbleText = null;
      }
    }
  }

  void draw()
  {
    if (_speechBubbleText != null)
    {
      int w = 150;
      int h = 2*(w/3);

      int x = _x - w / 2;
      int y = _y - (h + 20);
      y -= 50; // fudge relating to half height of character;

      fill(255);
      rect(x, y, w, h, 10);
      triangle(x+(w/2), y+h, x+(w/2) + 20, y+h, x+(w/2)+10, y+h+20);

      fill(0);
      textSize(16);
      text(_speechBubbleText, x+10, y+10, w-20, h-20);
    }  

    shape(_sprite, _x, _y);

    if (_blinkTime < 0)
    {
      shape(_eyes_blink, _x, _y);

      if (_blinkTime < -50)
      {
        _blinkTime = _blinkRate;
      }
    } else
    {
      shape(_eyes_open, _x, _y);
    }
  }

  void say(String speechBubbleText, int speechBubbleTime)
  {
    _speechBubbleTime = speechBubbleTime;
    _speechBubbleText = speechBubbleText;
  }
}


class furnitureActor extends actor
{
  public furnitureActor(String imageFilename, int x, int y, int z)
  {
    super();

    _sprite = loadShape(imageFilename);
    _x = x;
    _y = y;
    _z = z;
  }
  
  public furnitureActor(String imageFilename, int x, int y)
  {
    super();

    _sprite = loadShape(imageFilename);
    _x = x;
    _y = y;
  }

  void draw()
  {
    shape(_sprite, _x, _y);
  }
}

