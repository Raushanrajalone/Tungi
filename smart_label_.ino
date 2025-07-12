#include <Servo.h>

Servo rejectArm;
Servo labelServo;

int productSensor = 2;  // IR OUT pin (we simulate this manually)

void setup() {
  Serial.begin(9600);
  Serial.println("System Ready...");

  pinMode(productSensor, INPUT);

  rejectArm.attach(9);   // Rejection arm
  labelServo.attach(6);  // Labeling servo

  rejectArm.write(0);
  labelServo.write(0);
}

void loop() {
  // Simulate IR sensor detecting an object (force LOW once every 10 sec)
  static unsigned long lastTrigger = 0;
  if (millis() - lastTrigger > 10000) {
    Serial.println("Simulated IR detection...");
    Serial.println("CAPTURE_IMAGE");
    lastTrigger = millis();
  }

  // Wait for Python AI to reply
  if (Serial.available()) {
    String decision = Serial.readStringUntil('\n');

    if (decision == "ACCEPT") {
      Serial.println(" Product accepted. Printing label...");
      labelServo.write(90);
      delay(1000);
      labelServo.write(0);
    }
    else if (decision == "REJECT") {
      Serial.println(" Product rejected. Activating reject arm...");
      rejectArm.write(90);
      delay(1000);
      rejectArm.write(0);
    }
  }

  delay(100);
}
