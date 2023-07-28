   
     //----------------------------------------------------------------//
    // File name: GalaxyGame                                          //
   // Date: 2022-12-22                                               //
  // Programmers: Ran and Dimitry                                   //
 // Description: This program is the Final Version of Galaxy game  //
//----------------------------------------------------------------//

//button variables
int rectX=255;
int rectY=250;
int rectW=285;
int rectH=100;

int rectX2=0;
int rectY2=540;
int rectW2=60;
int rectH2=60;
//text variables

//explosion
boolean spriteTrigger=false;
int numFrames=4;
PImage[] spriteImages= new PImage [numFrames];
int currentFrame=0;
int posX=0;
int posY=0;
//state
int state=1;

//sound variables
import processing.sound.*;

SoundFile shoot;
SoundFile explosion;
SoundFile bgSong;
SoundFile background;

//image variables
int img1X=0;
int img1Y=0;
int img1H;

int img2X=0;
int img2Y=-img1H;
int img2H;

float bgSpeed=8;

PFont font;
PImage img1;
PImage img2;
PImage ship;
PImage bullet;
PImage asteroid;
PImage titleScreen;
PImage spaceEnd;
PImage hearts3;
PImage hearts2;
PImage heart1;

//ability variables
boolean infaShoot=false;
boolean stop1=false;
boolean timeSlow=false;
boolean stop2=false;

// ship variables
int shipW = 95;
int shipX = 350;
int shipY = 500;
int shipSpeed = 5;

// bullet variables
boolean[] bulletVisible= new boolean[100];
int[] bulletX=new int [100];
int[] bulletY=new int [100];
int bulletW = 8;
int bulletH = 30;
int bulletSpeed = 10;
int currentBullet = 0;

// diameter of the ball
float ballD[]= new float [100];           

//ball variable
int ballX[] = new int[100];
int ballY[] = new int[100];
boolean ballVisible[] = new boolean[100];
float ballSpeed=8;

//Score
int score = 0;
int lives = 3;

// distance between the current bullet and ball
int dist;

// an array that holds the key input (LEFT and RIGHT arrow + SPACE)
boolean[] keys;
boolean triggerReleased;


/* TASK 9
 Instead of "automatic fire" with multiple bullets, generate a single bullet every time the SPACE bar is pressed.
 To do this you need a variable that will check if the "trigger" is "released" before drawing another bullet.
 Declare a variable triggerReleased and determine its value at the begining, since the shooting has not started yet.
 Find where and how the variable is used inside the program to limit the bullets generated with one key press.
 */

//////////////////////////////////////////////////
// FUNCTIONS                                   //
////////////////////////////////////////////////

/* TASK 10
 Copy the functions from Template1 and Template2 into the space provided. The functions moveBullets and moveBalls
 need to be taken from the main Programs of the two templates and placed as separate functions
 */
//--------------------------------------------//
void reset() {
  score = 0;
  bgSpeed=8;
  ballSpeed=8;
  lives=3;
  stop1=false;
  stop2=false;
   generateBalls();
  infaShoot=false;
  timeSlow=false;
}
//-------------------------------------------//
void endWin() {
  image(spaceEnd, 0, 0);
  textSize(45);
  text("You Won!", width/2, 150);
  text("You cleared "+score/10+" astroids,", width/2, 190);
  text("Well done!", width/2, 230);

  textSize(25);
  if (mouseX>rectX2 && mouseX<rectX2+rectW2+50 && mouseY>rectY2-540 && mouseY<rectY2-540+rectH2) {
    fill(0, 0, 0, 50);
    rect(rectX2, rectY2-540, rectW2+50, rectH2);
    fill(0, 0, 100);
    text("Back", rectX2+55, rectY2-500);
    if (mousePressed==true && mouseButton==LEFT) {
      state=1;
      clear();
      reset();
    }
  } else {
    fill(0, 0, 0, 20);
    rect(rectX2, rectY2-540, rectW2+50, rectH2);
    fill(0, 0, 100);
    text("Back", rectX2+55, rectY2-500);
  }
}
//-------------------------------------------//
void endLose() {
  image(spaceEnd, 0, 0);
  textSize(45);
  text("You lost", width/2, 150);
  text("You cleared "+score/10+" astroids", width/2, 225);

  textSize(25);
  if (mouseX>rectX2 && mouseX<rectX2+rectW2+50 && mouseY>rectY2-540 && mouseY<rectY2-540+rectH2) {
    fill(0, 0, 0, 50);
    rect(rectX2, rectY2-540, rectW2+50, rectH2);
    fill(0, 0, 100);
    text("Back", rectX2+55, rectY2-500);
    if (mousePressed==true && mouseButton==LEFT) {
      state=1;
      reset();
      clear();
    }
  } else {
    fill(0, 0, 0, 20);
    rect(rectX2, rectY2-540, rectW2+50, rectH2);
    fill(0, 0, 100);
    text("Back", rectX2+55, rectY2-500);
  }
}
//-------------------------------------------//
void startScreen() {
  image(titleScreen, 0, 0);
  textFont(font, 75);
  text("Galaxy Game", width/2, 150);
  textFont(font, 60);
  fill(0, 0, 0, 18);
  rect(rectX, rectY, rectW, rectH);
  fill(0, 0, 100);
  text("START", rectX+rectW/2, rectY+70);
  if (mouseX>rectX && mouseX<rectX+rectW && mouseY>rectY && mouseY<rectY+rectH) {
    fill(0, 0, 0, 50);
    rect(rectX, rectY, rectW, rectH);
    fill(0, 0, 100);
    text("START", rectX+rectW/2, rectY+70);
    if (mousePressed==true && mouseButton==LEFT) {
      state=3;
      clear();
    }
  } else {
    fill(0, 0, 0, 20);
    rect(rectX, rectY, rectW, rectH);
    fill(0, 0, 100);
    text("START", rectX+rectW/2, rectY+70);
  }

  fill(0, 0, 0, 20);
  rect(rectX2, rectY2, rectW2, rectH2);
  fill(0, 0, 100);
  text("i", rectX2+30, rectY2+55);
  if (mouseX>rectX2 && mouseX<rectX2+rectW2 && mouseY>rectY2 && mouseY<rectY2+rectH2) {
    fill(0, 0, 0, 50);
    rect(rectX2, rectY2, rectW2, rectH2);
    fill(0, 0, 100);
    text("i", rectX2+30, rectY2+55);
    if (mousePressed==true && mouseButton==LEFT) {
      state=2;
      clear();
    }
  } else {
    fill(0, 0, 0, 20);
    rect(rectX2, rectY2, rectW2, rectH2);
    fill(0, 0, 100);
    text("i", rectX2+30, rectY2+55);
  }
}
//-------------------------------------------//
void instructions() {
  image(titleScreen, 0, 0);
  textSize(75);
  text("How to play", width/2, 125);
  textSize(30);
  text("Press 'Arrow Keys' to Move", width/2, 250);
  text("Press 'Space' to Shoot.", width/2, 320);
  text("Earn points by shooting astroids", width/2, 390);
  text("Objective: Destroy 250 astroids", width/2, 460);
  fill(0, 0, 0, 20);
  rect(rectX2, rectY2-540, rectW2+50, rectH2);
  fill(0, 0, 100);
  text("Back", rectX2+55, rectY2-500);
  if (mouseX>rectX2 && mouseX<rectX2+rectW2+50 && mouseY>rectY2-540 && mouseY<rectY2-540+rectH2) {
    fill(0, 0, 0, 50);
    rect(rectX2, rectY2-540, rectW2+50, rectH2);
    fill(0, 0, 100);
    text("Back", rectX2+55, rectY2-500);
    if (mousePressed==true && mouseButton==LEFT) {
      state=1;
      clear();
    }
  } else {
    fill(0, 0, 0, 20);
    rect(rectX2, rectY2-540, rectW2+50, rectH2);
    fill(0, 0, 100);
    text("Back", rectX2+55, rectY2-500);
  }
}
//-------------------------------------------//
void generateBalls() {
  for (int i=0; i<100; i++) {
    ballX[i]=int(random(0, width));
    ballY[i]=int(random(-20*height, 0));
    ballD[i]=random(35, 90);
    ballVisible[i]=true;
  }
}
//-------------------------------------------//
void generateBullets() {
  for (int i=0; i<100; i++) {
    bulletX[i]=50;
    bulletY[i]=-50;
    bulletVisible[i]=false;
  }
}
//-------------------------------------------//
void redrawGameField() {
  background(0);
  image(img1, img1X, img1Y);
  image(img2, img2X, img2Y);
  textSize(50);
  text(score + "/2500", width/2, 50);

  for (int i=0; i<100; i++) {
    if (ballVisible[i]==true) {
      image(asteroid, ballX[i], ballY[i], ballD[i], ballD[i]);
    }
  }

  for (int i=0; i<100; i++) {
    if (bulletVisible[i]==true) {
      fill(0, 0, 100);
      image(bullet, bulletX[i], bulletY[i], bulletW, bulletH);
    }
  }
  image(ship, shipX, shipY, shipW, shipW);

  shipX=constrain(shipX, 0, width-shipW);
  shipY=constrain(shipY, 300, height-shipW);
}
//-------------------------------------------//
void moveBackground() {
  img1Y=img1Y+int(bgSpeed);
  if (img1Y+int(bgSpeed)>img1H)img1Y=-img2H;

  img2Y=img2Y+int(bgSpeed);
  if (img2Y+int(bgSpeed)>img2H)img2Y=-img2H;
}
//-------------------------------------------//
void moveBalls() {
  for (int i=0; i<100; i++) {
    ballY[i]+=ballSpeed;

    if (ballY[i] >= height + ballD[i]/2) {
      ballY[i]=-5520;
    }
  }
}
//-------------------------------------------//
void moveBullets() {
  for (int i=0; i<100; i++) {
    if (bulletVisible[i]==true) {
      bulletY[i]-=bulletSpeed;
    }
    if (bulletY[i] <= -7) {
      bulletVisible[i]=false;
    }
  }
  if (timeSlow) {
    frameRate(20);
    bulletSpeed=20;
    shipSpeed=10;
  }
  if (!timeSlow) {
    frameRate(60);
    bulletSpeed=10;
    shipSpeed=5;
  }
}
//-------------------------------------------//
void lives() {
  if (lives==3) {
    image(hearts3, width-220, 20);
  }
  if (lives==2) {
    image(hearts2, width-220, 20);
  }
  if (lives==1) {
    image(heart1, width-220, 20);
  }
  for (int i = 0; i<100; i++) {
    dist = distance(ballX[i]+5, ballY[i]+5, shipX, shipY);
    if (ballVisible[i]==true && dist < ballD[i]) {
      explosion.play();
      ballY[i]=-5520;
      ballX[i]=int(random(0, width));
      spriteTrigger=true;
      posX=ballX[i];
      posY=ballY[i];
      lives=lives-1;
      score=score+10;
    }
  }
}
//-------------------------------------------//

// check for collison between the vidible bullets and visible balls using the distance function
void checkCollision() {
  for (int i = 0; i<100; i++) {
    for (int j = 0; j<100; j++) {
      dist = distance(ballX[i]+5, ballY[i]+5, bulletX[j], bulletY[j]);
      if (ballVisible[i]==true && bulletVisible[j]==true && dist < ballD[i]) {
        explosion.play();
        bulletVisible[j] = false;
        spriteTrigger=true;
        posX=ballX[i];
        posY=ballY[i];
        ballY[i]=-5520;
        score=score+10;
        bgSpeed=bgSpeed*1.0025;
        ballSpeed=ballSpeed*1.0025;
      }
    }
  }
  // shoot bullets with SPACE BAR
  if (keys[2] && triggerReleased) {// triggerReleased is true when the SPACE bar is pressed
    shoot.play();
    if (!infaShoot) {
      triggerReleased = false;// then it turns into false to prevent creating more then one bullet
    }
    bulletX[currentBullet] = shipX+43;
    bulletY[currentBullet] = shipY-5;
    bulletVisible[currentBullet] = true;
    currentBullet++;
    if (currentBullet == 100) {
      currentBullet = 0;
    }
  } else if (keys[2]==false) {
    triggerReleased = true;
  }
}

void loadSprites() {
  for (int i=0; i<numFrames; i++) {
    spriteImages[i]=loadImage("frames000"+str(i+1)+".png");
    spriteImages[i].resize(60, 60);
  }
}
//-------------------------------------------//
void ability() {
  if (score>=250 && score<=750) {
    textSize(20);
    text("Auto Shoot Activated",130,30);
    text("Hold 'Space'",130,50);
    infaShoot=true;
  }
  if (score==760) {
    infaShoot=false;
    keys[2]=false;
  }
 if(score<=250){
   infaShoot=false;
  }
if(!stop2){
  textSize(15);
  text("Hold 'Z' to Use Ability",100,575);

  }
}
//-------------------------------------------//

void drawSprites(int posX, int posY) {
  if (spriteTrigger==true) {
    imageMode(CENTER);
    image(spriteImages[currentFrame], posX, posY);
    currentFrame++;
    if (currentFrame>=4) {
      spriteTrigger=false;
      currentFrame=0;
    }
  }
  imageMode(CORNER);
}
  //////////////////
 // Main Program //
//////////////////

void setup() {
  frameRate(60);
  size(800, 600);
  background(0);
  smooth();
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
  textAlign(CENTER);
  loadSprites();



  keys=new boolean[5];
  keys[0]=false;
  keys[1]=false;
  keys[2]=false;
  keys[3]=false;
  keys[4]=false;
  triggerReleased=false;

  generateBalls();
  generateBullets();

  font = createFont("BaksoSapi.ttf", 60);
  img1=loadImage("spaceBg.png");
  img2=loadImage("spaceBg.png");
  ship=loadImage("ship.png");
  asteroid=loadImage("Asteroid.png");
  bullet=loadImage("laser.png");
  titleScreen=loadImage("titleScreen.jpg");
  spaceEnd=loadImage("spaceEnd.png");
  hearts3=loadImage("3hearts.png");
  hearts2=loadImage("2hearts.png");
  heart1=loadImage("1heart.png");
  hearts3.resize(200, 75);
  hearts2.resize(200, 75);
  heart1.resize(200, 75);
  titleScreen.resize(1067, 600);
  spaceEnd.resize(width, height);

  img1H=img1.height-20;
  img2Y=-img1H;
  img2H=img2.height-20;

  background=new SoundFile(this, "background.mp3");
  shoot=new SoundFile(this, "laserfire.mp3");
  explosion=new SoundFile(this, "explosion.wav");
  explosion.amp(3);
  background.play();
}

void draw() {

  if (state==1)
  {
    startScreen();
  }
  if (state==2) {
    instructions();
  }
  if (state==3)
  {
      redrawGameField();
      moveBackground();
      ability();
      drawSprites(posX, posY);
      // move the ship with LEFT & RIGHT ARROWS KEYS
      //-----------------------------//
      if (keys[0]) {
        shipX = shipX + shipSpeed;
      }
      //-----------------------------//
      if (keys[1]) {
        shipX = shipX - shipSpeed;
      }
      //-----------------------------//
      if (keys[3]) {
        shipY = shipY - shipSpeed;
      }
      //-----------------------------//
      if (keys[4]) {
        shipY = shipY + shipSpeed;
      }
      //-----------------------------//
      checkCollision();
      moveBalls();
      moveBullets();
      lives();
    }
  if (score>=2500) {
    state=4;
    reset();
  }
  if (score<2500 && lives<=0) {
    state=5;
  }
  if (state==5) {
    endLose();
  }
  if (state==4) {
    endWin();
  }
}

// a functions that calculates and returns the distance between two points as a decimal number
int distance (int x1, int y1, int x2, int y2) {
  return int(sqrt(pow((x1 - x2), 2) + pow((y1 - y2), 2)));
  }


void keyPressed() {
  // move the ship left / right with the arrow keys
  if (key==CODED && keyCode==RIGHT) keys[0]=true;
  if (key==CODED && keyCode==LEFT)  keys[1]=true;
  if (key==CODED && keyCode==UP) keys[3]=true;
  if (key==CODED && keyCode==DOWN)  keys[4]=true;
  // shoot bullets when SPACE BAR is pressed
  if (key==' ') keys[2]=true;
  if (!stop2) {
    if (keyCode=='z' || keyCode=='Z') {
      timeSlow=true;
    }
  }
}

void keyReleased() {
  if (key==CODED && keyCode==RIGHT) keys[0]=false;
  if (key==CODED && keyCode==LEFT) keys[1]=false;
  if (key==CODED && keyCode==UP) keys[3]=false;
  if (key==CODED && keyCode==DOWN) keys[4]=false;
  if (key==' ') keys[2]=false;
  //ability 1
  if (keyCode=='x' || keyCode=='X') {
    infaShoot=false;
    stop1=true;
  }
  if (keyCode=='z' || keyCode=='Z') {
    timeSlow=false;
    stop2=true;
  }
}
