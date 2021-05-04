
import processing.serial.Serial;
import java.awt.event.KeyEvent;
import java.awt.Robot;
import java.awt.AWTException;

Serial arduino  = null;
//Serial arduino2 = null;

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
/*
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
*/
boolean swapped = false;
boolean halt = false;
boolean pad2Halted = true;

void setup() {
  
  size(434,180);
  frameRate(60);

  ArrayList<String> portList = new ArrayList(java.util.Arrays.asList(Serial.list()));
  println(portList);
  
  if(portList.isEmpty())
  {
    print("No devices found.  Exiting.\n");
    System.exit(1);
  }
  
  try{
    arduino = new Serial(this, Serial.list()[0], 9600); // ATTENTION!!!
  }catch(java.lang.ArrayIndexOutOfBoundsException ex){
    arduino = null;
  }
  int tryPort = 0;
/*
    try{
      if(arduino != null)
        tryPort = 1;
      arduino2 = new Serial(this, Serial.list()[tryPort], 9600);
      //if(arduino2 == null){
        //print( "port " + tryPort + " is null.  Exiting.\n" );
        //System.exit(1);
      //}
    }catch(java.lang.ArrayIndexOutOfBoundsException ex){
      arduino2 = null;
      print(tryPort);
    }
  */
  bgImage = loadImage("NEScontroller.jpg");
  
  try
  {
    VKey = new Robot();
  }
  catch(AWTException a){}
  (new Thread(new DoEmulate())).start();
  //(new Thread(new DoEmulate2())).start();
  
  //prevout = 0;
}

void draw() {
  if (bgImage != null) { background(bgImage); }
  fill(255, 255, 0);
}

//char buttons_pad1[] = {'A','B','U','D','L','R','S','E'};
//dchar buttons_pad2[] = {'H','T','Y','I','O','P','F','G'};
int currentATime, currentBTime;
int oldATime=0, oldBTime=0;

void serialRead() {
  
  while (arduino.available() > 0) {
    recvout = arduino.readChar();
    //print(recvout);
    switch(recvout) {
      //  NES controller pad 1
    case 'U':
      VKey.keyPress(KeyEvent.VK_UP); 
      break;
      
    case '2':
      VKey.keyRelease(KeyEvent.VK_UP);
      break;
      
    case 'D': 
      VKey.keyPress(KeyEvent.VK_DOWN); 
      break;
      
    case '3':
      VKey.keyRelease(KeyEvent.VK_DOWN);
      break;
      
    case 'L': 
      VKey.keyPress(KeyEvent.VK_LEFT); 
      break;
      
    case '4':
      VKey.keyRelease(KeyEvent.VK_LEFT);
      break;
      
    case 'R': 
      VKey.keyPress(KeyEvent.VK_RIGHT);
      break; 
      
    case '5':
      VKey.keyRelease(KeyEvent.VK_RIGHT);
      break;
      
    case 'E':
      //VKey.keyPress(KeyEvent.VK_E);
      VKey.keyPress(KeyEvent.VK_ESCAPE);
      break; 
      
    case '7':
      //VKey.keyRelease(KeyEvent.VK_E);
      VKey.keyRelease(KeyEvent.VK_ESCAPE);
      break;
      
    case 'S': 
      VKey.keyPress(KeyEvent.VK_ENTER);
      break; 
      
    case '6':
      VKey.keyRelease(KeyEvent.VK_ENTER);
      break;
      
    case 'B': 
    //if((millis() - oldBTime) > 70) {
      VKey.keyPress(KeyEvent.VK_Z);
    //  oldBTime = millis();
    //}
      break;
      
    case '1':
      VKey.keyRelease(KeyEvent.VK_Z);
      break;
      
    case 'A':
    //if((millis() - oldATime) > 120) {
      VKey.keyPress(KeyEvent.VK_X); 
    //  oldATime = millis();  
  //}
      break;
      
    case '0':
      VKey.keyRelease(KeyEvent.VK_X);
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
/*
void DoPad2ElectricBoogaloo() {
   //if(arduino2 != null)
     while(arduino2.available() > 0) {
       //if(halt)
        //{
         // while(halt){ pad2Halted = true; }
         // pad2Halted = false;
        //}
        char receiveb;
        receiveb = arduino2.readChar();
        print(receiveb);
       switch(receiveb) {
      //  NES controller pad 2 -- {'R','T','Y','I','O','P','F','G'};
      case 'G': 
        VKey.keyPress(KeyEvent.VK_G); 
        break;
        
      case '7':
        VKey.keyRelease(KeyEvent.VK_G);
        break;
        
      case 'F': 
        VKey.keyPress(KeyEvent.VK_F); 
        break;
        
      case '6':
        VKey.keyRelease(KeyEvent.VK_F);
        break;
        
      case 'M': 
        VKey.keyPress(KeyEvent.VK_M); 
        break;
        
      case '5':
        VKey.keyRelease(KeyEvent.VK_M);
        break;
        
      case 'N': 
        VKey.keyPress(KeyEvent.VK_N);
        break; 
        
      case '4':
        VKey.keyRelease(KeyEvent.VK_N);
        break;
        
      case 'V': 
        VKey.keyPress(KeyEvent.VK_V);
        break; 
        
      case '3':
        VKey.keyRelease(KeyEvent.VK_V);
        break;
        
      case 'C': 
        VKey.keyPress(KeyEvent.VK_C);
        break; 
        
      case '2':
        VKey.keyRelease(KeyEvent.VK_C);
        break;
        
      case 'X': 
        VKey.keyPress(KeyEvent.VK_X);
        break;
        
      case '1':
        VKey.keyRelease(KeyEvent.VK_X);
        break;
        
      case 'Z':
        VKey.keyPress(KeyEvent.VK_Z); 
        break;
        
      case '0':
        VKey.keyRelease(KeyEvent.VK_Z);
        break;
      default:
      }    
    }
}
*/
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
