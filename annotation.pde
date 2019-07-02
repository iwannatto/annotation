import controlP5.*;

ControlP5 Button;
PImage img, pen, pen1, pen2;  
int index = 0;
ArrayList<ArrayList<PVector>> strokes = new ArrayList();
ArrayList<PVector> oneStroke = new ArrayList();
float time;
float penColorRgb;

void setup() {
  size(1024, 768);
  
  img = loadImage("images/image0.jpg");
  pen1 = loadImage("pen1.png");
  pen2 = loadImage("pen2.png");
  
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
  pen = pen1;

  time= millis();
}


void draw() {
  background(0);
  image(img, 0, 0);
  
  if (mouseIsOnImage()) {
    cursor(pen, 0, pen.height - 1);
  } else {
    cursor(ARROW);
  }

  if (strokes.size() == 0) { return; }
  for (ArrayList<PVector> s : strokes) {
    if (s.size() == 0) { continue; }
    PVector u = s.get(0);
    for (PVector v : s) {
      stroke(penColorRgb);
      strokeWeight(3);
      line(u.x, u.y, v.x, v.y);
      u = v;
    }
  }
}

void mousePressed() {
  if (mouseIsOnImage()) {
    oneStroke = new ArrayList();
    strokes.add(oneStroke);
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
  strokes.clear();
}

void setPenColor1() {
  penColorRgb = 0;
  pen = pen1;
}

void setPenColor2() {
  penColorRgb = 255;
  pen = pen2;
}

void undo() {
  if (strokes.size() != 0) {
    strokes.remove(strokes.size() - 1);
  }
}

boolean mouseIsOnImage() {
  return mouseX <= img.width && mouseY <= img.height;
}
