abstract class timeSource
{
  abstract int hours();
  abstract int minutes();
  abstract int seconds();
}

class realTimeClockSource extends timeSource
{
  int hours()
  {
    return hour() % 12;
  }
  int minutes()
  {
    return minute();
  }
  int seconds()
  {
    return second();
  }
}



class clock
{
  timeSource _timeSource;
  int _x, _y;
  float _r;

  public clock(int x, int y, int r, timeSource source)
  {
      _timeSource = source;
      _x = x;
      _y = y;
      _r = (float)r;
  }

  void draw()
  {
    fill(255);

    strokeWeight(1);
    ellipse(_x, _y, _r*2, _r*2);

    float r1 = (float)_r * 0.80; // seconds and minutes
    float r2 = (float)_r * 0.55; // hour 

    strokeWeight(3);
    float h = map(_timeSource.hours(), 0, 12, 0, TWO_PI) - HALF_PI;
    line(_x, _y, _x + cos(h) * r2, _y + sin(h) * r2);

    strokeWeight(2);
    float m = map(_timeSource.minutes(), 0, 60, 0, TWO_PI) - HALF_PI;
    line(_x, _y, _x + cos(m) * r1, _y + sin(m) * r1);

    strokeWeight(1);
    float s = map(_timeSource.seconds(), 0, 60, 0, TWO_PI) - HALF_PI;
    line(_x, _y, _x + cos(s) * r1, _y + sin(s) * r1);
  }
}

