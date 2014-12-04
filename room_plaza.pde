

class room_plaza extends roomActor
{
  public room_plaza()
  {
    super();

    _name = "plaza";
    _carpet = new plainCarpet(color(100, 100, 200));

    _doors.add(new trigger(200, 250, 75, "changeroom home"));
    _doors.add(new trigger(400, 0, 75, "changeroom racetrack"));
    _doors.add(new trigger(600, 400, 75, "changeroom hatshop"));
    _furniture.add(new furnitureActor("data/plaza_benihouse.svg", 200, 250));
    _furniture.add(new furnitureActor("data/plaza_benihouse.svg", 600, 375));
  }

  void whenEnteredFrom(String lastRoomName)
  {
    if (lastRoomName.equals("home"))
    {
      broadcast("movebeni 200,350");
    }
    if (lastRoomName.equals("racetrack"))
    {
      broadcast("movebeni 400,80");
    }
    if (lastRoomName.equals("hatshop"))
    {
      broadcast("movebeni 500,400");
    }
  }
}

