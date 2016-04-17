import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val1;
Boolean execute;
int start = 1;
int temperature;
int humidity = 23;
int altitude = 57;
int UV = 93;
void setup()
{
  //set backgrounds 
  size(801,801);
  background(0);
  fill(#739BE8);
  rect(5,150,155,555);
   fill(#73E8A0);
  rect(160,150,155,555);
   fill(#E273E8);
  rect(315,150,155,555);
   fill(#E87380);
  rect(470,150,155,555);
   fill(0);
  text("Temperature", 15, 190);
  text("Humidity", 233, 190);
  text("Altitude", 385, 190);
  text("UV", 547, 190);

String portName = Serial.list()[7]; //change the 0 to a 1 or 2 etc. to match your port
myPort = new Serial(this, portName, 115200); 
printArray(Serial.list());

}

void draw()
{

    int[] nums = {0,0,0,0};
  if ( myPort.available() > 0) 
  {  // If data is available,
  val1 = removeLine(myPort.readString());
  
  execute = check(val1);
  println(val1);
  if (execute)
  {
    println("YAY!");
  val1 = val1.substring(val1.indexOf('#')+1, val1.indexOf('!'));
  println(val1);
  // read it and store it in val
 //print it out in the console
 nums = int(split(val1, '/'));

  temperature = nums[0];
  println(temperature);
  humidity = nums[1];
  println(humidity);
  altitude = nums[2];
  println(altitude);
  UV = nums[3];
  println(UV);
  }
  else
  {
  }
    fill(#739BE8);
  rect(5,150,155,555);
   fill(#73E8A0);
  rect(160,150,155,555);
   fill(#E273E8);
  rect(315,150,155,555);
   fill(#E87380);
  rect(470,150,155,555);
   fill(0);
  text("Temperature", 15, 190);
  text("Humidity", 233, 190);
  text("Altitude", 385, 190);
  text("UV", 547, 190);
  for (int tem = 0; tem < 100; tem = tem+1) {
    if (100-tem > temperature)
    {
      fill(225);
    }
    else if (100-tem == temperature)
    {
      fill(0);
      text(temperature+ "ºC", 80 + 7, 200+ tem*5);
    }
    else
    {
      fill(#FF030B);
    }
  rect(80, 200+ tem*5, 5, 5);
}
  for (int hum = 0; hum < 100; hum = hum+1) {
   if (100-hum > humidity)
    {
      fill(225);
    }
    else if (100-hum == humidity)
    {
      fill(0);
      text(humidity+ "%", 235 + 7, 200+ hum*5);
    }
    else
    {
      fill(#0326FF);
    }
  rect(235, 200+ hum*5, 5, 5);
}
 for (int alt = 0; alt < 100; alt = alt+1) {
     if (100-alt > altitude)
    {
      fill(225);
    }
    else if (100-alt == altitude)
    {
      fill(0);
      text(altitude+ "m", 390 + 7, 200+ alt*5);
    }
    else
    {
      fill(#FFF703);
    }
  rect(390, 200 + alt*5, 5, 5);
}
 for (int uv = 0; uv < 100; uv = uv+1) {
       if (100-uv > UV)
    {
      fill(225);
    }
    else if (100-uv == UV)
    {
      fill(0);
      text(UV+ "mW/cm^2", 535 + 7, 200+ uv*5);
    }
    else
    {
      fill(#FF8103);
    }
  rect(535, 200+ uv*5, 5, 5);
 }
 }
 }
Boolean check(String data)
{
     int count = 0;
     if (data.length() > 2)
     {
  char letterOne = data.charAt(0);
  char lastLetter = data.charAt(data.length()-1);
  if (letterOne == '#')
  {
    println("CHECKONE!");
    if (lastLetter == '!')
    {
      println(lastLetter);
    println("CHECKTWO!");
 
    for (int i = 1; i < data.length()-1; i++)
    {
     char currentChar = data.charAt(i);
     if (currentChar == '/')
     {
      count += 1;
     }
     
    }
    if (count == 3)
     {
      println("CHECKTHREE!");
      return true; 
     }
     else 
     {
       return false;
     }
  }
  }
  return false;
     }
     else
     {
       return false;
     }
}
String removeLine(String numbers)
{
  for (int i = 1; i < numbers.length()-1; i++)
    {
     int blank = numbers.charAt(i);
      if (blank == '\n')
      {
        numbers = numbers.substring(0, i) + numbers.substring(i+1);
      }
    }
    return numbers;
}