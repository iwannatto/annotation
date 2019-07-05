import controlP5.*;

ControlP5 Button;
PImage img, pen, pen1, pen2, pen1_icon, pen2_icon;  
int index = 0;
ArrayList<ArrayList<PVector>> strokes = new ArrayList();
ArrayList<PVector> oneStroke = new ArrayList();
float time;
int penColorRgb;

PImage icon(PImage pen_img) {
  PImage icon = pen_img.copy();
  //icon.resize(icon.width * 3, icon.height * 3);
  //color black = icon.pixels[0], white = color(255, 255, 255);
  //for (int i = 0; i < icon.width * icon.height; ++i) {
  //  if (icon.pixels[i] == black) {
  //    icon.pixels[i] = white;
  //  }
  //}
  //icon.updatePixels();
  return icon;
}

void setup() {
  size(1024, 768);
  
  img = loadImage("images/image0.jpg");
  pen1 = loadImage("58_171_210.png");
  pen2 = loadImage("223_86_86.png");
  pen1_icon = icon(pen1);
  pen2_icon = icon(pen2);
    
  Button = new ControlP5(this);
  Button.addButton("done")
    .setLabel("ok!")
    .setPosition(10, height-130)
    .setSize(150, 60);
  Button.addButton("setPenColor1")
    .setImage(pen1_icon)
    .setPosition(700, 50);
  Button.addButton("setPenColor2")
    .setImage(pen2_icon)
    .setPosition(700, 100);
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
  penColorRgb = #3AABD2;
  pen = pen1;
}

void setPenColor2() {
  penColorRgb = #DF5656;
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
