class Bullet{
  int type;
  float x,y;
  PVector speed;
  boolean valid;
  Bullet(float x, float y, int type,PVector speed){
    this.x = x;
    this.y = y;
    this.type = type;
    this.speed = speed;
    valid = true;
  }
  
  void display(){// display bullet
    if(valid){
        noStroke();
    if(type == 1){
      fill(251,191,20);    
    }else{
      fill(233,65,52); 
    }
    ellipse(x,y,10,10);
    }
   
  
  }
  
  
  void update(){
    x+=speed.x;
    y+=speed.y;  
  }
  

  void check(){
    if(valid){
        if(type == 1){
      if(dist(x,y,monsterX,monsterY)<150){
        bloodmonster -=1;
        valid = false;
      }    
    }else{
         if(dist(x,y,heroX,heroY)<150){
        bloodHero -=1;
        valid = false;
      }
    }
    }

  }


}
