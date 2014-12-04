int sceneWidth = 800;
int sceneHeight = 600;

int lastTime = millis();

ArrayList<roomActor> world;

roomActor currentRoom;

beniActor beni;


void setup()
{
  size(sceneWidth, sceneHeight);

  beni = new beniActor();
  beni.say("Hi! My name is Beni! Welcome to my world :D", 3000);

  world = new ArrayList<roomActor>();
  world.add(new room_home());
  world.add(new room_plaza());
  world.add(new room_racetrack());
  world.add(new room_hatshop());

  currentRoom = getRoom("home");
} 


void draw()
{
  int elapsed = millis() - lastTime;
  lastTime = millis();

  beni.update(elapsed);
  currentRoom.update(elapsed);

  currentRoom.draw();  

  // debug
  String beniInfo = currentRoom._name + "   x: " + beni._x + "  y: " + beni._y;
  fill(0);
  text(beniInfo, 10, 20);
}


roomActor getRoom(String name)
{
  for (roomActor room : world)
  {
    if (room._name.equals(name))
    {
      return room;
    }
  }

  return null;
}


void broadcast(String actionCollection)
{
  String[] actions = actionCollection.split("[|]");
  for (String action : actions)
  {
    println(action);
    
    String[] actionTokens = action.split("[, ]+");

    beni.executeAction(actionTokens);
    currentRoom.executeAction(actionTokens);
  }
}

void keyPressed()
{
  currentRoom.keyPressed(key, keyCode);
}

void keyReleased()
{
  currentRoom.keyReleased(key, keyCode);
}

