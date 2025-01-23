import processing.pdf.*;

boolean record = false;

PFont myfont;
String mytext = "tap";

void setup(){  
  myfont = createFont("IBMPlexMono-Medium.ttf",8);
  size(794,1172);
  frameRate(5);
}

void draw(){
  
  
   if(record){
    beginRecord(PDF,"variacion_#####.pdf");
  }
  background(80);
  fill(0);
  zumbido(0,0);
  base(0,115);
  TdiagonalDECRECIENTE (-100, 500);
  TdiagonalCRECIENTE(-110, 920);
  AdiagonalDECRECIENTE(-100, 150);
  AdiagonalCRECIENTE(-110, 700);
  //flechaarriba(100,150);
  
  if(record){
    endRecord();
    record = false;
  }
}


void zumbido(float posx, float posy) { 
  for (float x = 0; x < 900; x += 10) {
    for (float y = 0; y < 100; y += random(10, 50)) {  // Variación aleatoria en los saltos de y
      push();
      translate(posx + x, posy + y);
      rotate(radians(random(0, 360)));  // Rotación aleatoria
      text("p", 0, 0);
      pop();
    }
  }
}
void triangulo() {
  for (int y = 405; y <= height-300; y += 20) {
    for (int x = 400; x <= y; x += 20) {
      text("tap", x, y);
    }
  }
}

void flechaarriba(float offsetX, float offsetY) { 
  int baseWidth = 550; 
  for (int y = 350 + int(offsetY); y <= height - 50 + int(offsetY); y += 20) {  
    for (int x = (width - baseWidth) / 2 + int(offsetX); x <= (width + baseWidth) / 2 + int(offsetX); x += 25) {
      text("tap", x, y);  
    }
    baseWidth -= 50;  
  }
}

void flechaabajo() {
  int baseWidth = 200;  // Ancho de la base de la pirámide
  for (int y = 450; y <= height-50; y += 20) {  
    for (int x = (width - baseWidth) / 2; x <= (width + baseWidth) / 2; x += 25) {
      text("tap", x, y);  
    }
    baseWidth -= 50;  
  }
}
void base(float posx, float posy) { 
  for (float x=0; x<900; x+=10) {
    for (float y=0; y<100; y+=random(500)) {
      push();
      translate(posx + x, posy + y);
      
      push();
      rotate(radians(90));
      text("p", 0, 0);
      pop();
      
      pop();
    }
  }
}
void diagonalDERarriba(float posx, float posy) {
  for (float x=100; x<600; x+=20) {
      for (float y=0; y<200; y+=15) {
      push();
      translate(posx, posy);
      text("t", x, -x+y);
      pop();
      }
  }
}
void diagonalAD(float posx, float posy) {
  for (float x=100; x<600; x+=20) {
      for (float y=0; y<200; y+=15) {
      push();
      translate(posx, posy);
      text("a", x, -x+y);
      pop();
      }
  }
}
void diagonalPD(float posx, float posy) {
  for (float x=100; x<600; x+=20) {
      for (float y=0; y<200; y+=15) {
      push();
      translate(posx, posy);
      text("p", x, -x+y);
      pop();
      }
  }
}
void diagonalDERabajo(float posx, float posy) { 
  for (float x=100; x<600; x+=20) {
      for (float y=5; y<200; y+=15) {
      push();
      translate(posx, posy);
      text("t", x, x + y);
      pop();
      }
  }
}
void diagonalIZQarriba(float posx, float posy) { 
  for (float x=100; x<600; x+=20) {
      for (float y=5; y<200; y+=15) {
      push();
      translate(posx, posy);
      text("t", x, x + y);
      pop();
      }
  }
}
void diagonalIZQabajo(float posx, float posy) {
  for (float x=100; x<600; x+=20) {
      for (float y=0; y<200; y+=15) {
      push();
      translate(posx, posy);
      text("t", x, -x+y);
      pop();
      }
  }
}
void TdiagonalDECRECIENTE(float posx, float posy) { 
  for (float x=100; x<1100; x+=random(5,40)) {
      for (float y=5; y<400; y+=30) {
      push();
      translate(posx, posy);
      text("tap", x, x + y);
      pop();
      }
  }
}
void TdiagonalCRECIENTE(float posx, float posy) {
  for (float x=100; x<900; x+=random(5,10)) {
      for (float y=0; y<45; y+=15) {
      push();
      translate(posx, posy);
      text("t", x, -x+y);
      pop();
      }
  }
}
void AdiagonalDECRECIENTE(float posx, float posy) { 
  for (float x=100; x<900; x+=20) {
      for (float y=random(0,20); y<60; y+=25) {
      push();
      translate(posx, posy);
      text("p", x, x + y);
      pop();
      }
  }
}
void AdiagonalCRECIENTE(float posx, float posy) {
  for (float x=random(70,100); x<random(200, 5000); x+=7) {
      for (float y=random(40,100); y<200; y+=7) {
      push();
      translate(posx, posy);
      text("a", x, -x+y);
      pop();
      }
  }
}
void mousePressed() {
  record = true;
}
