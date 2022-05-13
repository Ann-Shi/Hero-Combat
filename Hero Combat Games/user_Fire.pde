class user_Fire {
  float x = xpos + 10;
  float y = ypos + 20;
  float xspeed = 5;
  
  void user_fire(){
    x =  x + xspeed;
    if (x > width){
      x = xpos + 10;
      y = ypos + 20;
    }
  }
  void user_show(){
    stroke(138, 43, 226);
    strokeWeight(10);
    point(x, y);
  }
}
