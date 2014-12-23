class room_closet extends roomActor
{
  public room_closet()
  {
    super();
    _name= "closet";
    _carpet = new plainCarpet(color(200, 200, 0));
    
    _doors.add(new trigger(400, 600, 75, "changeroom home"));
  }
  
  void whenEnteredFrom(String lastRoomName)
  {
    if (lastRoomName.equals("home"))
    {
      broadcast("movebeni 400,500");
    }
  }


}

    
  
