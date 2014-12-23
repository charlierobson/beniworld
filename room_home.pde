

class room_home extends roomActor
{
  public room_home()
  {
    super();

    _name = "home";
    _carpet = new plainCarpet(color(200, 100, 100));
    
    _doors.add(new trigger(400, 600, 75, "changeroom plaza"));
    _doors.add(new trigger(400, 0, 75, "changeroom closet"));
    
    _furniture.add(new furnitureActor("data/home_bed.svg", 200, 200));
    _furniture.add(new clock(700, 100, 45, new realTimeClockSource()));
  }

  void whenEnteredFrom(String lastRoomName)
  {
    if (lastRoomName.equals("plaza"))
    {
      broadcast("movebeni 400,520");
    }
    if (lastRoomName.equals("closet"))
    {
      broadcast("movebeni 400,100");
    }
  }

  void draw()
  {
    super.draw();
  }
}

