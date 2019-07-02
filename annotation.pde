import controlP5.*;

ControlP5 Button;
PImage img;  
int index = 0;
ArrayList<ArrayList<PVector>> points = new ArrayList();
ArrayList<PVector> oneStroke = new ArrayList();
float time;
float penColorRgb;

void setup() {
  size(1024, 768);
  
  img = loadImage("images/image0.jpg");
  
  Button = new ControlP5(this);
  Button.addButton("done")
    .setLabel("Done")
    .setPosition(10, height-50)
    .setSize(100, 40);
  Button.addButton("setPenColor1")
    .setLabel("pen1")
    .setPosition(700, 50)
    .setSize(100, 40);
  Button.addButton("setPenColor2")
    .setLabel("pen2")
    .setPosition(700, 100)
    .setSize(100, 40);
  Button.addButton("undo")
    .setLabel("undo")
    .setPosition(700, 150)
    .setSize(100, 40);

  setPenColor1();

  time= millis();
}


void draw() {
  background(0);
  image(img, 0, 0);

  fill(255);
  if (points.size() == 0) { return; }
  for (ArrayList<PVector> s : points) {
    if (s.size() == 0) { continue; }
    PVector u = s.get(0);
    for (PVector v : s) {
      stroke(penColorRgb);
      strokeWeight(4);
      line(u.x, u.y, v.x, v.y);
      u = v;
    }
  }
}

void mousePressed() {
  if (mouseX <= img.width && mouseY <= img.height) {
    oneStroke = new ArrayList();
    points.add(oneStroke);
  } else {
    oneStroke = null;
  }
}

void mouseDragged() {
  if (oneStroke != null) {
    oneStroke.add(new PVector(mouseX, mouseY));
  }
}

void done() {
  println(index+" "+(millis()-time)+" ms");
  time= millis(); 

  index++;
  img = loadImage("images/image"+index+".jpg");  
  points.clear();
}

void setPenColor1() {
  penColorRgb = 0;
}

void setPenColor2() {
  penColorRgb = 255;
}

void undo() {
  if (points.size() != 0) {
    points.remove(points.size() - 1);
  }
}
