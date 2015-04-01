import processing.serial.*;  

Serial port;
float ratioX = 10.5;
int ratioY = 6;
int nbStep = 1;
int posX = 0;
int posY = 0;
boolean xp, xn, yp, yn =false;
boolean process = false;

boolean drawBatman = true;
PImage img;
Point s;
Point last;
color c1 = #FFCC00;
ArrayList <Point> pointList = new ArrayList();


int rad = 400;
int x =147;
int y =362;

int cx = 309;
int cy = 201;

float a = 0.02;
int count =0;

boolean xturn = true;


void setup() {
  background(255);
 size(3500  , 2000);
  frameRate(100);
  println(Serial.list()); // List COM-ports
  //select second com-port from the list (COM3 for my device)
  // You will want to change the [1] to select the correct device
  // Remember the list starts at [0] for the first option.

  port = new Serial(this, Serial.list()[0], 9600);

  if (drawBatman) {
    img = loadImage("bat.jpg");
    img.loadPixels();
    // image(img, 0, 0);
    for (int x=0; x< img.width; x++) {
      for (int y=0; y< img.height; y++) {
        int loc = x+y *img.width;
        if (brightness(img.pixels[loc]) < 90) {
          s = new Point(x*ratioX, y*ratioY);
          x= (int)(s.getX());
          y=(int)(s.getY());
          return;
        }
      }
    }
  }
}

void draw()
{
  if (process) {
    if ( (x == cx && y ==cy) || count < 7) {
      compute();
      count++;
    }
    else {
      point(cx,cy);
      if (xturn) {
        moveX();
      }
      else {
        moveY();
      }
      xturn = !xturn;
    }
    println( " x: " + x + " y:  " +y);
    point(x, y);
  }
  else {


    if (xp) {
      port.write(nbStep+"q");
      posX +=nbStep;
    }
    if (xn) {
      port.write(nbStep+"d");
      posX -=nbStep;
    }
    if (yp) {
      port.write(nbStep+"z");
      posY +=nbStep;
    }

    if (yn) {
      port.write(nbStep+"s");
      posY -=nbStep;
    }

    println("x:"+posX);
    println("y:"+posY);
  }
}


void moveX() {
  if (x==cx)return;
  x = ((x-cx)<0)?xpf():xnf();
}

void moveY() {
  if (y==cy)return;
  y = ((y-cy)<0)?ypf():ynf();
}

int xpf() {
  port.write(nbStep+"q");
  return x+nbStep;
}

int xnf() {
  port.write(nbStep+"d");
  return x-nbStep;
}

int ypf() {
  port.write(nbStep+"z");
  return y+nbStep;
}

int ynf() {
  port.write(nbStep+"s");
  return y-nbStep;
}

boolean checkPoint(float x, float y){
  Point comPoint;
  for (int i=0; i < pointList.size() ; i=i+1 ) {
        comPoint = pointList.get(i);
        if(comPoint.isEqual(x,y)){
          return false;
        }
  }
  return true;
} 
void compute() {
  if(drawBatman){
    int  i = (int)(s.getX()/ratioX);
  int j = (int) (s.getY()/ratioY); 
  for(int z=1 ; z<100;z++){
    for(int x=i-z; x<i+z;x++){
      for(int y=j-z; y<j+z;y++){
        int loc = x+y *img.width;
          if(loc>0 && loc < img.pixels.length && (brightness(img.pixels[loc]) < 90) && checkPoint(x*ratioX,y*ratioY)){
            last=s;
            s = new Point(x*ratioX,y*ratioY);
            pointList.add(s);
            cx = (int) (s.getX());
            cy = (int) (s.getY());
            return;
          }
      }
    }
  } 
  }else{
  a += 0.01; 

  float cfx = cos(a)*rad*1.75 + rad*1.75;
  float cfy = sin(a)*rad + rad;

  cx = (int) cfx;
  cy = (int) cfy;
  }
}


void keyPressed() {
  if (keyCode==RIGHT)
  {
    xn =true;
    xp =false;
  }
  if (keyCode==LEFT)
  {
    xp =true;
    xn =false;
  }
  if (keyCode==UP)
  {
    yp =true;
    yn =false;
  }
  if (keyCode==DOWN)
  {
    yn =true;
    yp =false;
  }
}

void keyReleased()
{
  if (keyCode==RIGHT)
  {
    xn =false;
  }
  if (keyCode==LEFT)
  {
    xp =false;
  }
  if (keyCode==UP)
  {
    yp =false;
  }
  if (keyCode==DOWN)
  {
    yn =false;
  }
}

