class trigger
{
  public int _x, _y, _r;
  public String _actions;

  int _state;

  public trigger(int x, int y, int r, String actions)
  {
    _x = x;
    _y = y;
    _r = r;
    _actions = actions;

    _state = 0; // not triggered
  }

  void check(actor target)
  {
    float distance = dist(target._x, target._y, _x, _y);
    if (distance < _r)
    {
      if (_state == 0)
      {
        // become triggered
        _state = 1;
        broadcast(_actions);
      }
    } else
    {
      // become untriggered
      _state = 0;
    }
  }
}
