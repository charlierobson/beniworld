class beniActor extends characterActor
{
  PShape _hat;

  public beniActor()
  {
    super("beni");

    _x = sceneWidth / 2;
    _y = sceneHeight / 2;
    _z = 150;
  }

  void draw()
  {
    super.draw();
    if (_hat != null)
    {
      shape(_hat, _x, _y);
    }
  }

  void executeAction(String[] actionTokens)
  {
    if (actionTokens[0].equals("movebeni"))
    {
      _x = Integer.parseInt(actionTokens[1]);
      _y = Integer.parseInt(actionTokens[2]);
    }
  }
}

