class carpet
{
  void draw()
  {
  }
}


class plainCarpet extends carpet
{
  color _floorColour;

  public plainCarpet(color colour)
  {
    _floorColour = colour;
  }

  public void draw()
  {
    background(_floorColour);
  }
}


class fancyCarpet extends carpet
{
  PImage _carpet;

  public fancyCarpet(String carpetFilename)
  {
    _carpet = loadImage(carpetFilename);
  }

  public void draw()
  {
    image(_carpet, 0, 0);
  }
}

