#include <ESP8266WiFi.h>
#define SERVER_PORT 80
const char* ssid = "KD";
const char* password = "Dhanu29112000";
WiFiServer server(SERVER_PORT);
int i;
const byte L9110S_A_In1_pin = 4; // D2
const byte L9110S_A_In2_pin = 14; // D5
const byte L9110S_B_In3_pin = 12; // D6
const byte L9110S_B_In4_pin = 15; // D8
void setup()
{ pinMode(4, OUTPUT);
  pinMode(16, OUTPUT);
  pinMode(L9110S_A_In1_pin, OUTPUT);
  pinMode(L9110S_A_In2_pin, OUTPUT);
  pinMode(L9110S_B_In3_pin, OUTPUT);
  pinMode(L9110S_B_In4_pin, OUTPUT);
  analogWrite(L9110S_A_In1_pin, 0);
  analogWrite(L9110S_A_In2_pin, 0);
  analogWrite(L9110S_B_In3_pin, 0);
  analogWrite(L9110S_B_In4_pin, 0);
  Serial.begin(115200);
  Serial.println("");
  Serial.println("");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  server.begin();
  Serial.println("Server started");
  for (i = 0; i < 25; i++)
  { digitalWrite(16, HIGH);
    delay(40);
    digitalWrite(16, LOW);
    delay(40);
  }
  ESP.wdtDisable();
  ESP.wdtEnable(WDTO_8S);
}
void loop()
{
  WiFiClient client = server.available();
  if (client)
  {
    Serial.println("new client");
    for (i = 0; i < 2; i++)
    { digitalWrite(16, HIGH);
      delay(50);
      digitalWrite(16, LOW);
      delay(50);
    }
    while (1)
    {
      while (client.available())
      { 
        digitalWrite(16, HIGH);
        delay(100);
        digitalWrite(16, LOW);
        delay(100);
        uint8_t data = client.read();
        Serial.write(data);
        switch (data) 
        {
          case 'f': 
            analogWrite(L9110S_A_In1_pin, 0);
            analogWrite(L9110S_A_In2_pin, 1000);
            analogWrite(L9110S_B_In3_pin, 0);
            analogWrite(L9110S_B_In4_pin, 1000);
            break;
          case 'e': 
            analogWrite(L9110S_A_In1_pin, 1000);
            analogWrite(L9110S_A_In2_pin, 0);
            analogWrite(L9110S_B_In3_pin, 1000);
            analogWrite(L9110S_B_In4_pin, 0);
            break;
          case 'r': 
            analogWrite(L9110S_A_In1_pin, 1024);
            analogWrite(L9110S_A_In2_pin, 0);
            analogWrite(L9110S_B_In3_pin, 0);
            analogWrite(L9110S_B_In4_pin, 1024);
            break;
          case 'l': 
            analogWrite(L9110S_A_In1_pin, 0);
            analogWrite(L9110S_A_In2_pin, 1024);
            analogWrite(L9110S_B_In3_pin, 1024);
            analogWrite(L9110S_B_In4_pin, 0);
            break;
          case 's': 
            analogWrite(L9110S_A_In1_pin, 0);
            analogWrite(L9110S_A_In2_pin, 0);
            analogWrite(L9110S_B_In3_pin, 0);
            analogWrite(L9110S_B_In4_pin, 0);
            break;
        }
      }
      if (server.hasClient())
      {
        return;
      }
    }
  }
}
