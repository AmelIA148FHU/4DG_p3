import processing.pdf.*;

boolean record;
void setup(){
  size(300,300);
  frameRate(2);
}
void draw(){
  background(200);
  float ample=random(35, 115);
  float alt=random(30, 200);
  noFill();
  strokeWeight(20);
  stroke(#1D1D1B);
  arc(150,150,ample,alt,radians(180),radians(360));  
  strokeWeight(2);
  fill(#3C3C3B);
  ellipse(175-ample,150,ample/1.25,alt/1.25);//izq gran
  ellipse(125+ample,150,ample/1.25,alt/1.25);
  fill(#1D1D1B);
  ellipse(175-ample,150,ample/2.25,alt/2.25);
  ellipse(125+ample,150,ample/2.25,alt/2.25);
  println(mouseY);
}
void mousePressed() {
  record = true;
}
