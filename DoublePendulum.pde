float r1 = 120;  // Length of the first pendulum arm
float r2 = 150;  // Length of the second pendulum arm
float r3 = 180;  // Length of the third pendulum arm

float m1 = 6;   // Mass/size of the first pendulum bob
float m2 = 5;   // Mass/size of the second pendulum bob
float m3 = 4;  // Mass/size of the third pendulum bob

float a1 = PI / 2; // Initial angle for the first pendulum
float a2 = PI / -2; // Initial angle for the second pendulum
float a3 = PI / 4; // Initial angle for the third pendulum

float a1_v = 0;   // Initial angular velocity for the first pendulum
float a2_v = 0;   // Initial angular velocity for the second pendulum
float a3_v = 0;   // Initial angular velocity for the third pendulum

float g = .275;      // Gravity

PVector origin;
PVector bob1, pbob1;
PVector bob2, pbob2;
PVector bob3, pbob3;

float bobSize = 3;

boolean joinLines = true;
boolean printJoints = true;
boolean printBob1 = true;
boolean printBob2 = true;
boolean printBob3 = true;

void setup() {
  //frameRate(120);
  size(960, 960, P3D);
  smooth(16);
  //blendMode(MULTIPLY);
  origin = new PVector(width / 2, height * .45);
  pbob1 = bob1 = new PVector();
  pbob2 = bob2 = new PVector();
  pbob3 = bob3 = new PVector();
  background(0);
  stroke(50, 255, 255);
  fill(255);
}

void draw() {
  
  //background(0, 16);
  fill(0, 10);
  rect(0, 0, width, height);
  strokeWeight(1);

  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1 - 2 * a2);
  float num3 = -2 * sin(a1 - a2) * m2;
  float num4 = a2_v * a2_v * r2 + a1_v * a1_v * r1 * cos(a1 - a2);

  float den = r1 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));

  float a1_a = (num1 + num2 + num3 * num4) / den;

  num1 = 2 * sin(a1 - a2);
  num2 = (a1_v * a1_v * r1 * (m1 + m2));
  num3 = g * (m1 + m2) * cos(a1);
  num4 = a2_v * a2_v * r2 * m2 * cos(a1 - a2);
  den = r2 * (2 * m1 + m2 - m2 * cos(2 * a1 - 2 * a2));

  float a2_a = (num1 * (num2 + num3 + num4)) / den;

  // Calculate motion for the third pendulum
  float num5 = -g * (2 * m1 + m2 + m3) * sin(a3);
  float num6 = -m2 * g * sin(a3 - 2 * a2);
  float num7 = -2 * sin(a3 - a2) * m2;
  float num8 = a2_v * a2_v * r2 + a3_v * a3_v * r3 * cos(a3 - a2);

  float den2 = r3 * (2 * m1 + m2 + m3 - m2 * cos(2 * a3 - 2 * a2));

  float a3_a = (num5 + num6 + num7 * num8) / den2;

  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);

  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);

  float x3 = r1 * sin(a1) + r2 * sin(a2) + r3 * sin(a3);
  float y3 = r1 * cos(a1) + r2 * cos(a2) + r3 * cos(a3);

  pbob1 = bob1.copy();
  pbob2 = bob2.copy();
  pbob3 = bob3.copy();

  bob1.set(x1, y1);
  bob2.set(x2, y2);
  bob3.set(x3, y3);

  translate(origin.x, origin.y);

  if (printBob1) {
    stroke(0, 150, 200);
    line(0, 0, bob1.x, bob1.y);
  }
  if (printJoints) {
    fill(255);
    stroke(255);
    ellipse(bob1.x, bob1.y, bobSize, bobSize);
  }
  if (joinLines) {
    line(bob1.x, bob1.y, pbob1.x, pbob1.y);
  }

  if (printBob2) {
    stroke(10, 180, 225);
    line(bob1.x, bob1.y, bob2.x, bob2.y);
  }
  if (printJoints) {
    fill(255);
    stroke(255);
    ellipse(bob2.x, bob2.y, bobSize, bobSize);
  }
  if (joinLines) {
    line(bob2.x, bob2.y, pbob2.x, pbob2.y);
  }

  if (printBob3) {
    stroke(50, 255, 255);
    line(bob2.x, bob2.y, bob3.x, bob3.y);
  }
  if (printJoints) {
    fill(255);
    stroke(255);
    ellipse(bob3.x, bob3.y, bobSize, bobSize);
  }
  if (joinLines) {
    strokeWeight(8);
    stroke(255);
    line(bob3.x, bob3.y, pbob3.x, pbob3.y);
  }

  a1_v += a1_a;
  a2_v += a2_a;
  a3_v += a3_a;

  a1 += a1_v;
  a2 += a2_v;
  a3 += a3_v;
  
}
