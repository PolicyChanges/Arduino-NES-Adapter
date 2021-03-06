/*
Description:  Interfacing a NES controller with a PC with an Arduino.
Coded by:  Prodigity
Date:    1 December 2011
Revision:  V0.9 (beta)
*/

import processing.serial.*;
import java.awt.event.KeyEvent;
import java.awt.*;

Serial arduino;
Serial arduino2;

Robot VKey;

PImage bgImage;

char recvout;

class DoEmulate implements Runnable
{
  public void run() {
     while(true)
     {
      serialRead();
      try {
        Thread.sleep(1);
      }catch(java.lang.InterruptedException e){
        print("DoEmulate threw up\n");
      }
    }
  }
}

class DoEmulate2 implements Runnable
{
  public void run() {
     while(true)
     {
      DoPad2ElectricBoogaloo();
      try {
        Thread.sleep(1);
      }catch(java.lang.InterruptedException e){
        print("DoEmulate2 threw up\n");
      }
    }
  }  
}

boolean swapped = false;
boolean halt = false;
boolean pad2Halted = true;

void setup() {
  
  size(434,180);
  frameRate(30);

  ArrayList<String> portList = new ArrayList(java.util.Arrays.asList(Serial.list()));
  println(portList);
  
  if(portList.isEmpty())
  {
    print("No devices found.  Exiting.\n");
    return;
  }
  /*
  try{
    arduino = new Serial(this, Serial.list()[0], 9600); // ATTENTION!!!
  }catch(java.lang.ArrayIndexOutOfBoundsException ex){
    arduino = null;
  }
  */
  if(portList.size() > 1)
  {
    try{
      arduino2 = new Serial(this, Serial.list()[1], 9600);
    }catch(java.lang.ArrayIndexOutOfBoundsException ex){
      arduino2 = null;
    }
  }
  
  bgImage = loadImage("NEScontroller.jpg");
  
  try
  {
    VKey = new Robot();
  }
  catch(AWTException a){}
  //(new Thread(new DoEmulate())).start();
  (new Thread(new DoEmulate2())).start();
  
  //prevout = 0;
}

void draw() {
  if (bgImage != null) { background(bgImage); }
  fill(255, 255, 0);
}

//char buttons_pad1[] = {'A','B','U','D','L','R','S','E'};
//dchar buttons_pad2[] = {'H','T','Y','I','O','P','F','G'};

void serialRead() {
  while (arduino.available() > 0) {
    //recvout = arduino.readChar();
    //print(recvout);
    switch(arduino.readChar()) {
      //  NES controller pad 1
    case 'U': 
      VKey.keyPress(KeyEvent.VK_U); 
      break;
      
    case '2':
      VKey.keyRelease(KeyEvent.VK_U);
      break;
      
    case 'D': 
      VKey.keyPress(KeyEvent.VK_D); 
      break;
      
    case '3':
      VKey.keyRelease(KeyEvent.VK_D);
      break;
      
    case 'L': 
      VKey.keyPress(KeyEvent.VK_L); 
      break;
      
    case '4':
      VKey.keyRelease(KeyEvent.VK_L);
      break;
      
    case 'R': 
      VKey.keyPress(KeyEvent.VK_R);
      break; 
      
    case '5':
      VKey.keyRelease(KeyEvent.VK_R);
      break;
      
    case 'E':
      VKey.keyPress(KeyEvent.VK_E);
      break; 
      
    case '7':
      VKey.keyRelease(KeyEvent.VK_E);
      break;
      
    case 'S': 
      VKey.keyPress(KeyEvent.VK_S);
      break; 
      
    case '6':
      VKey.keyRelease(KeyEvent.VK_S);
      break;
      
    case 'B': 
      VKey.keyPress(KeyEvent.VK_B);
      break;
      
    case '1':
      VKey.keyRelease(KeyEvent.VK_B);
      break;
      
    case 'A':
      VKey.keyPress(KeyEvent.VK_A); 
      break;
      
    case '0':
      VKey.keyRelease(KeyEvent.VK_A);
      break;
     default:
     /*
     if(swapped)
     {
       print("Something strange happened. Check arduino code for pad output. Exiting.\n");
       System.exit(1);
     }
     //  Lock pad2 thread
     while(pad2Halted == false)
     {
       try{
         Thread.sleep(1);
       }catch(InterruptedException ex){
         print("InterruptedException in pad1 thread.  Exiting\n");
         System.exit(1);
       }
     }
     
     //  Swap controllers
     Serial temp;
     temp = arduino;
     arduino = arduino2;
     arduino2 = temp;
     
     //  Flag swapped
     swapped = true;
     
     //  Unlock pad2 thread
     pad2Halted = false;
     */
    }
  }
}

void DoPad2ElectricBoogaloo() {
     while(arduino2.available() > 0) {
       /*if(halt)
        {
          while(halt){ pad2Halted = true; }
          pad2Halted = false;
        }*/
       switch(arduino2.readChar()) {
      //  NES controller pad 2 -- {'R','T','Y','I','O','P','F','G'};
      case 'G': 
        VKey.keyPress(KeyEvent.VK_G); 
        break;
        
      case 15:
        VKey.keyRelease(KeyEvent.VK_G);
        break;
        
      case 'F': 
        VKey.keyPress(KeyEvent.VK_F); 
        break;
        
      case 14:
        VKey.keyRelease(KeyEvent.VK_F);
        break;
        
      case 'M': 
        VKey.keyPress(KeyEvent.VK_M); 
        break;
        
      case 13:
        VKey.keyRelease(KeyEvent.VK_M);
        break;
        
      case 'N': 
        VKey.keyPress(KeyEvent.VK_N);
        break; 
        
      case 12:
        VKey.keyRelease(KeyEvent.VK_N);
        break;
        
      case 'V': 
        VKey.keyPress(KeyEvent.VK_V);
        break; 
        
      case 11:
        VKey.keyRelease(KeyEvent.VK_V);
        break;
        
      case 'C': 
        VKey.keyPress(KeyEvent.VK_C);
        break; 
        
      case 10:
        VKey.keyRelease(KeyEvent.VK_C);
        break;
        
      case 'X': 
        VKey.keyPress(KeyEvent.VK_X);
        break;
        
      case '9':
        VKey.keyRelease(KeyEvent.VK_X);
        break;
        
      case 'Z':
        VKey.keyPress(KeyEvent.VK_Z); 
        break;
        
      case '8':
        VKey.keyRelease(KeyEvent.VK_Z);
        break;
      default:
      }    
    }
}
/*
U
2
D
3
L
4
R
5
E
7
S
6
B
1
A
0
*/

