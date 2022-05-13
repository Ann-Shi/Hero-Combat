class Fire {
  float x = width;
  float y = random(0, height);
  float yspeed = random(3, 4);
  
  void fire(){
    x =  x - yspeed;
    if (x < 0){
      x = width;
    }
  }
  void show(){
    stroke(138, 43, 226);
    strokeWeight(10);
    point(x, y);
  }
}
