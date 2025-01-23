import controlP5.*;
import processing.pdf.*;

ControlP5 cp5;

Slider slider_deformacion; // Slider para controlar la deformación del árbol
Slider slider_bolas;       // Slider para la cantidad de bolas
ScrollableList scrollablelist_arbol;
ScrollableList scrollablelist_fondo;
Button savePngButton;
Button savePdfButton;

int num_bolas = 5;        // Cantidad inicial de bolas
float deformacion = 100;  // Valor inicial de deformación

String[] colors = {"Verde","Negro", "Rojo", "Azul", "Rosa"};
color[] triangleColors = {color(0, 140, 57), color(0, 0, 0), color(214, 41, 41), color(57, 67, 255), color(255, 102, 175)};
color triangleColor = triangleColors[0];
color backgroundColor = color(0); // Color inicial del fondo

// Lista de triángulos y sus vértices
ArrayList<Triangle> triangles = new ArrayList<Triangle>();
ArrayList<MovingBall> movingBalls = new ArrayList<MovingBall>(); // Bolas en movimiento

// Variables para detectar cambios en los sliders
int last_num_bolas = num_bolas;
float last_deformacion = deformacion;

// Variables para la animación
float starAngle = 0; // Ángulo inicial de rotación de la estrella

void setup() {
  size(1000, 1000);
  frameRate(60);
  cp5 = new ControlP5(this);

  // Slider para la deformación del árbol
  slider_deformacion = cp5.addSlider("deformacion")
    .setRange(390, 600)   // Rango de deformación
    .setNumberOfTickMarks(20) // Número de marcas de posición
    .setValue(500)        // Valor inicial
    .setPosition(10, 30)
    .setSize(250, 20)
    .setLabel("Deformar árbol");

  // Slider para la cantidad de bolas
  slider_bolas = cp5.addSlider("num_bolas") 
    .setPosition(10, 80) // Posición en la pantalla
    .setSize(250, 20)     // Tamaño del slider
    .setRange(0, 30)      // Rango de cantidad de bolas
    .setNumberOfTickMarks(15) // Número de marcas de posición
    .setValue(15)         // Valor inicial
    .setSliderMode(Slider.FIX) // Modo fijo del slider
    .setLabel("Cantidad Bolas");

  // ScrollableList para el color del árbol
  scrollablelist_arbol = cp5.addScrollableList("changeTreeColor")
    .setPosition(10, 130)
    .setSize(100, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(colors)
    .setValue(0) // Default selection
    .setLabel("Color Árbol");

  // ScrollableList para el color del fondo
  scrollablelist_fondo = cp5.addScrollableList("changeBackgroundColor")
    .setPosition(130, 130)
    .setSize(100, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(colors)
    .setValue(0) // Default selection
    .setLabel("Color Fondo");
    
  // Botón para guardar PNG
  savePngButton = cp5.addButton("PNG")
    .setPosition(10, 250)
    .setSize(100, 30)
    .onClick(event -> savePng());

  // Botón para guardar PDF
  savePdfButton = cp5.addButton("PDF")
    .setPosition(130, 250)
    .setSize(100, 30)
    .onClick(event -> savePdf());

  generateTree();
  generateBalls();
}


void draw() {
  background(backgroundColor);

  // Leer los valores de los sliders
  deformacion = slider_deformacion.getValue();
  num_bolas = (int) slider_bolas.getValue();

  // Regenerar el árbol y las bolas si cambian los valores de los sliders
  if (num_bolas != last_num_bolas || deformacion != last_deformacion) {
    last_num_bolas = num_bolas;
    last_deformacion = deformacion;
    generateTree();
    generateBalls();
  }

  // Dibujar el tronco
  fill(255);
  noStroke();
  rectMode(CENTER);
  rect(width / 2, 680, 70, 260);

  // Dibujar el árbol
  drawTree();

  // Dibujar las bolas en movimiento
  for (MovingBall ball : movingBalls) {
    ball.update();
    ball.display();
  }

  // Dibujar la estrella amarilla de 9 puntas en la punta del árbol con rotación
  fill(255, 236, 0); // Amarillo
  noStroke();

  // Calcula la posición del vértice superior del triángulo más alto
  Triangle topTriangle = triangles.get(0); // El primer triángulo es el superior
  float starX = topTriangle.x1;            // El vértice superior del triángulo
  float starY = topTriangle.y1 - 10;       // Un poco más arriba del triángulo

  pushMatrix();
  translate(starX, starY);
  rotate(starAngle);
  drawStar(0, 0, 15, 70, 12); // Dibuja la estrella
  popMatrix();

  starAngle += 0.02; // Incremento del ángulo para rotación continua
}

void drawStar(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle / 2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a + halfAngle) * radius1;
    sy = y + sin(a + halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void savePdf() {
  beginRecord(PDF, "arbol_con_bolas_####.pdf");
  draw();
  endRecord();
}

void savePng() {
  saveFrame("arbol_con_bolas_####.png");
}

void generateTree() {
  triangles.clear();
  for (int i = 0; i < 5; i++) {
    float x1 = width / 2;
    float y1 = height / 2 - 600 + 75 * i + 300;
    float x2 = width / 2 - 150;
    float y2 = height / 2 - 600 + 75 * i + deformacion;
    float x3 = width / 2 + 150;
    float y3 = height / 2 - 600 + 75 * i + deformacion;

    triangles.add(new Triangle(x1, y1, x2, y2, x3, y3));
  }
}

void drawTree() {
  push();
  translate(0, 0);
  fill(triangleColor);
  noStroke();
  for (Triangle t : triangles) {
    triangle(t.x1, t.y1, t.x2, t.y2, t.x3, t.y3);
  }
  pop();
}

void generateBalls() {
  movingBalls.clear();
  for (int i = 0; i < num_bolas; i++) {
    Triangle t = triangles.get((int) random(triangles.size()));

    float x, y;
    do {
      x = random(min(t.x1, min(t.x2, t.x3)), max(t.x1, max(t.x2, t.x3)));
      y = random(min(t.y1, min(t.y2, t.y3)), max(t.y1, max(t.y2, t.y3)));
    } while (!t.contains(x, y));

    movingBalls.add(new MovingBall(new PVector(x, y)));
  }
}

class Triangle {
  float x1, y1, x2, y2, x3, y3;

  Triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.x3 = x3;
    this.y3 = y3;
  }

  boolean contains(float px, float py) {
    float d1 = sign(px, py, x1, y1, x2, y2);
    float d2 = sign(px, py, x2, y2, x3, y3);
    float d3 = sign(px, py, x3, y3, x1, y1);

    boolean hasNeg = (d1 < 0) || (d2 < 0) || (d3 < 0);
    boolean hasPos = (d1 > 0) || (d2 > 0) || (d3 > 0);

    return !(hasNeg && hasPos);
  }

  float sign(float px, float py, float x1, float y1, float x2, float y2) {
    return (px - x2) * (y1 - y2) - (x1 - x2) * (py - y2);
  }
}

class MovingBall {
  PVector position;
  float offset;

  MovingBall(PVector position) {
    this.position = position.copy();
    this.offset = random(TWO_PI);
  }

  void update() {
    position.y += sin(frameCount * 0.05 + offset) * 0.5; // Movimiento vertical
  }

  void display() {
    fill(255);
    noStroke();
    ellipse(position.x, position.y, 20, 20);
  }
}

void changeTreeColor(int index) {
  color selectedColor = triangleColors[index];
  if (selectedColor == backgroundColor) {
    println("El color del árbol no puede ser igual al fondo.");
  } else {
    triangleColor = selectedColor;
  }
}

void changeBackgroundColor(int index) {
  color selectedColor = triangleColors[index];
  if (selectedColor == triangleColor) {
    println("El fondo no puede tener el mismo color que el árbol.");
  } else {
    backgroundColor = selectedColor;
  }
}
