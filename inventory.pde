class item
{
  public String _name;
  public String _description;
  public String _whenClicked;

  public int _price;
  public boolean _owned;
  
  public actor _actor;

  public item(String name, int price, String description, String whenClicked)
  {
    _name = name;
    _price = price;
    _description = description;
    _whenClicked = whenClicked;
    _owned = false;
  }

  public String imageName()
  {
    return "data/"+_name+".svg";
  }
}


class inventory
{
  ArrayList<item> _items;

  public ArrayList<item> items()
  {
    return _items;
  }
  
  public item findItemByName(String name)
  {
    for (item it : _items)
    {
      if (it._name.equals(name))
      {
        return it;
      }
    }
    
    return null;
  }
}

class inventory_hat extends inventory
{
  public inventory_hat()
  {
    _items = new ArrayList<item>();
    _items.add(new item("hat_red", 100, "A lovely red cap", "select hat_red"));
    _items.add(new item("hat_green", 100, "A stylish green Tam-O-Shanter", "select hat_green"));
    _items.add(new item("hat_beany", 250, "The Beany. One of a kind", "select hat_beany"));
    _items.add(new item("hat_derp", 500, "Derpy glasses. A brilliant disguise", "select hat_derp"));
    _items.add(new item("hat_top", 750, "A classy top hat. Classy.", "select hat_top"));
    _items.add(new item("hat_colander", 1001, "It looks like a colander... Now how did that get up there?", "select hat_colander"));
    _items.add(new item("hat_fish", 1250, "Fish hats, fish hats, rolly poll... oh, sorry, that's my dinner.", "select hat_fish"));
    _items.add(new item("hat_crown", 2000, "You'll be the envy of your country", "select hat_crown"));
  }
}

