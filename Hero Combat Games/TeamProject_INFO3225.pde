int index,xpos,ypos;//Selected the different screens
ArrayList<Bullet> bullets;
PImage[] imgs;
PImage monster,hero,fire1, fire2, cooling;
int heroX,heroY,monsterX,monsterY;//heros and monster
int speedX,speedY;//monster's speed
int bloodHero,bloodmonster;
String txt;
float speed;
float ystart = 0.0;
//star


void setup(){
  smooth();
  frameRate(30);
  size(1800,900);
  imageMode(CENTER);
  fire1 = createImage(width,height,RGB);
  fire2 = createImage(width,height,RGB);
  cooling = createImage(width,height,RGB);
  
  index = 0;
 
  imgs = new PImage[3];
  for(int i = 0;i<3;i++){
    imgs[i] = loadImage("H"+(i+1)+".png");  //loading the different image
  }
  monster = loadImage("monster.png");

  bullets = new ArrayList<Bullet>();
 
  heroX = width/2;
  heroY = height/2;
  monsterX = width-200;
  monsterY = 300;
  hero = imgs[0];
  speedX = -1;
  speedY = 1;
  bloodHero = 20;
  bloodmonster = 20;
  txt = "";
}
  

void draw(){

  speed = map(500, 0, width , 0, 50);
  background(0);
  pushMatrix();
  scale(2);
  fire(10);
  image(fire2,0,0);
  popMatrix();

  if(index == 0){
    starting();
  }else if(index == 1){//screen 1 
    choose();
  }else if(index == 2){  //screen2 
    gaming();
  }else if(index == 3){ //screen3
    gameover();
  }




}


void starting(){ //main page
  textSize(100);
  fill(255);
  text("Superhero  VS Monster",width/2-550, height/2);
      textSize(30);
  fill(255);
  text("Click to start",800,800);

}


void choose(){//the second screen
    for(int i = 0;i<3;i++){
    image(imgs[i],585+i*300,574,200,300);  
  }
    textSize(60);
  fill(251,191,20);
  text("Choose One of Hero:",564,115);

};

void gaming(){//vs
  
  textSize(20);
  fill(251,191,20);
  text("HERO:",130,115);
  rect(200,100,bloodHero*10,20);
  
  fill(233,65,52);
  text("Monster:",1485,115);
  rect(1555,100,bloodmonster*10,20);
  
  image(hero,heroX,heroY,200,300);
  image(monster,monsterX,monsterY,300,300);
  monsterX+=speedX;
  monsterY+=speedY;
 
  if(monsterX<150||monsterX>width-150){ //monster moving
    speedX*=-1;
  }
    if(monsterY<150||monsterY>height-150){
    speedY*=-1;
  }
  //VS
  if(frameCount%30==0){
      PVector speed = new PVector(heroX-monsterX,heroY-monsterY);
     bullets.add(new Bullet(monsterX,monsterY,0,speed.normalize().mult(3)));
  }
 
  for(Bullet bullet:bullets){
    bullet.check();
    bullet.update();
    bullet.display();
  
  }
  
//both side of blood 
  if(bloodHero==0){
    index=3;
    txt = "OPPS! YOU LOST";
  }
  if(bloodmonster==0){
    index=3;
    txt = "YOU WIN";
  }
 

}

void gameover(){// go back
  textSize(100);
  fill(255);
  text(txt,655,459);
  
    textSize(30);
  fill(255);
  text("Press r to restart",792,837);
}

void keyPressed(){
  if(key == 'w'){
    heroY-=1;  
  }
   if(key == 'a'){
    heroX-=1;  
  }
   if(key == 's'){
    heroY+=1;  
  }
   if(key == 'd'){
    heroX+=1;  
  }
   if(key == 'r'){
   setup();  
  }
  

}

void mouseClicked(){
  if(index == 2){
   
    PVector speed = new PVector(mouseX-heroX,mouseY-heroY);
     bullets.add(new Bullet(heroX,heroY,1,speed.normalize().mult(3)));
  }
  if(index == 0){
     index = 1;
  }

    if(index == 1){
      if(dist(mouseX,mouseY,585,572)<50){
        hero = imgs[0];
      index = 2;
      }
         if(dist(mouseX,mouseY,876,572)<50){
        hero = imgs[1];
      index = 2;
      }
         if(dist(mouseX,mouseY,1180,572)<50){
        hero = imgs[2];
      index = 2;
      }
     
  }
 

}

void fire(int rows){
  fire1.loadPixels();
  fire2.loadPixels();
  for (int x = 1; x < width -1; x++){
    for (int y = 1; y < height - 1; y++){
      int index0 = (x) + (y) * width;
      int index1 = (x+1) + (y) * width;
      int index2 = (x-1) + (y) * width;
      int index3 = (x) + (y+1) * width;
      int index4 = (x) + (y-1) * width;
      color c1 = fire1.pixels[index1];
      color c2 = fire1.pixels[index2];
      color c3 = fire1.pixels[index3];
      color c4 = fire1.pixels[index4];
      
      color c5 = cooling.pixels[index0];
      float newC = brightness(c1)+brightness(c2)+brightness(c3)+brightness(c4);
      newC = newC - brightness(c5);
      fire2.pixels[index4] = color(newC * 0.25);
    }
  
  }
  fire2.updatePixels();
  
  PImage temp = fire1;
  fire1 = fire2;
  fire2 = temp;
  fire1.loadPixels();
  for(int x = 0; x < width; x++){
    for (int z = 0; z < rows; z++){
      int y = height- (z+1);
      int index = x + y * width;
      fire1.pixels[index] = color(255);
    }
  }
  fire1.updatePixels();
  

  cooling.loadPixels();
  float xoff = 0.0; // Start xoff at 0
  float increment = 0.02;
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = ystart;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float n = noise(xoff,yoff);
      float bright = n * 50;

      // Try using this line instead
      //float bright = random(0,255);
      
      // Set each pixel onscreen to a grayscale value
     cooling.pixels[x+y*width] = color(bright);
    }
  }
  cooling.updatePixels();
  ystart += increment;
}
