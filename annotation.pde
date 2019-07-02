import controlP5.*;

ControlP5 Button;
PImage img;  
int index = 0;
ArrayList<PVector> points = new ArrayList();
float time;
float penRgb = 0;

void setup() {
  size(1024, 768);
  img = loadImage("images/image0.jpg");  // Load the image into the program 

  Button = new ControlP5(this);
  Button.addButton("done")
    .setLabel("Done")
    .setPosition(10, height-50)
    .setSize(100, 40);
  Button.addButton("pen1")
    .setLabel("pen1")
    .setPosition(700, 50)
    .setSize(100, 40);
  Button.addButton("pen2")
    .setLabel("pen2")
    .setPosition(700, 100)
    .setSize(100, 40);

  time= millis();
}


void draw() {
  background(0);
  image(img, 0, 0);

  fill(255);
  if (points.size() == 0) { return; }
  PVector u = points.get(0);
  for (PVector v : points) {
    strokeWeight(4);
    line(u.x, u.y, v.x, v.y);
    u = v;
  }
}

void mouseDragged() {
  points.add(new PVector(mouseX, mouseY));
}

void done() {
  println(index+" "+(millis()-time)+" ms");
  time= millis(); 

  index++;
  img = loadImage("images/image"+index+".jpg");  
  points.clear();
}

void pen1() {
  return;
}

void pen2() {
  return;
}
