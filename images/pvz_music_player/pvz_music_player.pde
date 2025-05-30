import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Dynamic Programming v Static
//
//Library - Minim
Minim minim;
AudioPlayer[] playList; // Adjust array size to hold five songs
int currentSongIndex = 0; // Index of the currently playing song
//
//Global Variables
int appWidth, appHeight;
float imageDivX, imageDivY, imageDivWidth, imageDivHeight;
float imageWidthChanged=0.0, imageHeightChanged=0.0; //IN if-statement
//
// Button Layout Variables
float beginningButtonSpace = 50;
float buttonY;
float widthOfButton = 100;

// Button Dimensions and Positions
float stopDivX, stopDivY, stopDivWidth, stopDivHeight;
float muteDivX, muteDivY, muteDivWidth, muteDivHeight;
float previousDivX, previousDivY, previousDivWidth, previousDivHeight;
float fastRewindDivX, fastRewindDivY, fastRewindDivWidth, fastRewindDivHeight;
float pauseDivX, pauseDivY, pauseDivWidth, pauseDivHeight;
float playDivX, playDivY, playDivWidth, playDivHeight;
float loopOnceDivX, loopOnceDivY, loopOnceDivWidth, loopOnceDivHeight;
float loopInfiniteDivX, loopInfiniteDivY, loopInfiniteDivWidth, loopInfiniteDivHeight;
float fastForwardDivX, fastForwardDivY, fastForwardDivWidth, fastForwardDivHeight;
float nextDivX, nextDivY, nextDivWidth, nextDivHeight;
float shuffleDivX, shuffleDivY, shuffleDivWidth, shuffleDivHeight;
float quitDivX, quitDivY, quitDivWidth, quitDivHeight;
float unmuteDivX, unmuteDivY, unmuteDivWidth, unmuteDivHeight;

PImage myFirstImage;
PImage quitButtonImage;
//
void setup() {
  //Display
  fullScreen();
  // size(700, 500);
  appWidth = width; //displayWidth
  appHeight = height; //displayHeight
  //
  //Population
  imageDivX = appWidth*1/4;
  imageDivY = appHeight*1/4;
  imageDivWidth = appWidth*1/2;
  imageDivHeight = appHeight*1/2;
  //
  //Image Aspect Ratio Algorithm
  String myFirstImagePathway = "images/pvz.jpg";
  myFirstImage = loadImage(myFirstImagePathway);
  if (myFirstImage == null) {
    println("Error: Image not found at " + myFirstImagePathway);
    exit();
  }
  int myFirstImageWidth = 640;
  int myFirstImageHeight = 360;
  float imageAspectRatioGreaterOne = ( myFirstImageWidth >= myFirstImageHeight ) 
    ? float(myFirstImageWidth) / myFirstImageHeight 
    : float(myFirstImageHeight) / myFirstImageWidth; // Fixed aspect ratio calculation
  println(imageAspectRatioGreaterOne);
  Boolean imageLandscape = ( myFirstImageWidth >= myFirstImageHeight ) ? true : false ;
  Boolean divLandscape = (imageDivWidth >= imageDivHeight ) ? true : false ;
  if ( imageLandscape ) {
    imageWidthChanged = imageDivWidth;
    imageHeightChanged = imageWidthChanged / imageAspectRatioGreaterOne; // Fixed height calculation
  } else {
    imageHeightChanged = imageDivHeight;
    imageWidthChanged = imageHeightChanged * imageAspectRatioGreaterOne; // Fixed width calculation
  }

  //Landscape includes square
  //imageWidthChanged, imageHeightChanged
  //
  //DIV
  rect( imageDivX, imageDivY, imageDivWidth, imageDivHeight );
  //
  //Prototype Images
  // Initialize Minim
  minim = new Minim(this);
  playList = new AudioPlayer[5]; // Adjust array size to hold five songs
  try {
    playList[0] = minim.loadFile("Crazy Dave (Intro Theme) _ Laura Shigihara.mp3"); // First song
    playList[1] = minim.loadFile("Loonboon _ Laura Shigihara.mp3"); // Second song
    playList[2] = minim.loadFile("▶︎ Ultimate Battle _ Laura Shigihara.mp3"); // Third song
    playList[3] = minim.loadFile("Zen Garden IN-GAME _ Laura Shigihara.mp3"); // Fourth song
    playList[4] = minim.loadFile("Plants Vs. Zombies 2 Music - Map.mp3"); // Fifth song
  } catch (Exception e) {
    println("Error: Audio file not found.");
    exit();
  }
  playList[currentSongIndex].play(); // Start with the first song

  // Load the image for the Quit button
  quitButtonImage = loadImage("images/OIP (1).jpg");
  if (quitButtonImage == null) {
    println("Error: Quit button image not found.");
    exit();
  }

  // Button Layout Initialization
  buttonY = appHeight - 200; // Lower the buttons by increasing the Y position

  stopDivX = beginningButtonSpace;
  stopDivY = buttonY;
  stopDivWidth = widthOfButton;
  stopDivHeight = widthOfButton;

  muteDivX = beginningButtonSpace + widthOfButton * 1;
  muteDivY = buttonY;
  muteDivWidth = widthOfButton;
  muteDivHeight = widthOfButton;

  previousDivX = beginningButtonSpace + widthOfButton * 2;
  previousDivY = buttonY;
  previousDivWidth = widthOfButton;
  previousDivHeight = widthOfButton;

  fastRewindDivX = beginningButtonSpace + widthOfButton * 3;
  fastRewindDivY = buttonY;
  fastRewindDivWidth = widthOfButton;
  fastRewindDivHeight = widthOfButton;

  pauseDivX = beginningButtonSpace + widthOfButton * 4;
  pauseDivY = buttonY;
  pauseDivWidth = widthOfButton;
  pauseDivHeight = widthOfButton;

  playDivX = beginningButtonSpace + widthOfButton * 5;
  playDivY = buttonY;
  playDivWidth = widthOfButton;
  playDivHeight = widthOfButton;

  loopOnceDivX = beginningButtonSpace + widthOfButton * 6;
  loopOnceDivY = buttonY;
  loopOnceDivWidth = widthOfButton;
  loopOnceDivHeight = widthOfButton;

  loopInfiniteDivX = beginningButtonSpace + widthOfButton * 7;
  loopInfiniteDivY = buttonY;
  loopInfiniteDivWidth = widthOfButton;
  loopInfiniteDivHeight = widthOfButton;

  fastForwardDivX = beginningButtonSpace + widthOfButton * 8;
  fastForwardDivY = buttonY;
  fastForwardDivWidth = widthOfButton;
  fastForwardDivHeight = widthOfButton;

  nextDivX = beginningButtonSpace + widthOfButton * 9;
  nextDivY = buttonY;
  nextDivWidth = widthOfButton;
  nextDivHeight = widthOfButton;

  shuffleDivX = beginningButtonSpace + widthOfButton * 10;
  shuffleDivY = buttonY;
  shuffleDivWidth = widthOfButton;
  shuffleDivHeight = widthOfButton;

  // Position the Quit button at the top-left corner
  quitDivX = 10; // Small margin from the left
  quitDivY = 10; // Small margin from the top
  quitDivWidth = widthOfButton;
  quitDivHeight = widthOfButton;

  // Add Unmute button dimensions
  unmuteDivX = beginningButtonSpace + widthOfButton * 12; // Position after the Quit button
  unmuteDivY = buttonY;
  unmuteDivWidth = widthOfButton;
  unmuteDivHeight = widthOfButton;
} //End setup
//
void draw() {
  // Draw title box
  fill(0, 128, 0); // Green background for the title box
  rect(appWidth / 2 - 150, 20, 300, 50); // Centered box at the top
  fill(255); // White text
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Plants Vs Zombies MP", appWidth / 2, 45);

  image(myFirstImage, imageDivX, imageDivY, imageWidthChanged, imageHeightChanged); // Display image with corrected dimensions

  // Draw buttons using universally recognizable symbols
  fill(0); // Black for Stop
  rect(stopDivX, stopDivY, stopDivWidth, stopDivHeight);
  fill(255);
  rect(stopDivX + stopDivWidth / 2 - 20, stopDivY + stopDivHeight / 2 - 20, 40, 40); // Square for Stop (symbolizing a "stop" button)

  fill(128, 128, 128); // Gray for Mute
  rect(muteDivX, muteDivY, muteDivWidth, muteDivHeight);
  fill(255);
  triangle(muteDivX + 30, muteDivY + muteDivHeight / 2 - 20, muteDivX + 30, muteDivY + muteDivHeight / 2 + 20, muteDivX + 70, muteDivY + muteDivHeight / 2); // Speaker shape
  line(muteDivX + 75, muteDivY + muteDivHeight / 2 - 15, muteDivX + 95, muteDivY + muteDivHeight / 2 + 15); // Diagonal line for "muted"

  fill(0, 255, 255); // Cyan for Unmute
  rect(unmuteDivX, unmuteDivY, unmuteDivWidth, unmuteDivHeight);
  fill(0);
  triangle(unmuteDivX + 30, unmuteDivY + unmuteDivHeight / 2 - 20, unmuteDivX + 30, unmuteDivY + unmuteDivHeight / 2 + 20, unmuteDivX + 70, unmuteDivY + unmuteDivHeight / 2); // Speaker shape
  arc(unmuteDivX + 80, unmuteDivY + unmuteDivHeight / 2, 30, 30, -PI / 4, PI / 4); // Sound wave 1
  arc(unmuteDivX + 100, unmuteDivY + unmuteDivHeight / 2, 50, 50, -PI / 4, PI / 4); // Sound wave 2

  fill(255, 255, 0); // Yellow for Previous Song
  rect(previousDivX, previousDivY, previousDivWidth, previousDivHeight);
  fill(0);
  triangle(previousDivX + 30, previousDivY + previousDivHeight / 2, previousDivX + 70, previousDivY + 20, previousDivX + 70, previousDivY + previousDivHeight - 20); // Triangle pointing left
  rect(previousDivX + 10, previousDivY + previousDivHeight / 2 - 20, 10, 40); // Vertical bar for Previous

  fill(255, 140, 0); // Dark Orange for Fast Rewind
  rect(fastRewindDivX, fastRewindDivY, fastRewindDivWidth, fastRewindDivHeight);
  fill(255);
  triangle(fastRewindDivX + 20, fastRewindDivY + fastRewindDivHeight / 2, fastRewindDivX + 50, fastRewindDivY + 10, fastRewindDivX + 50, fastRewindDivY + fastRewindDivHeight - 10); // Left triangle
  triangle(fastRewindDivX + 50, fastRewindDivY + fastRewindDivHeight / 2, fastRewindDivX + 80, fastRewindDivY + 10, fastRewindDivX + 80, fastRewindDivY + fastRewindDivHeight - 10); // Right triangle

  fill(255, 0, 0); // Red for Pause
  rect(pauseDivX, pauseDivY, pauseDivWidth, pauseDivHeight);
  fill(255);
  rect(pauseDivX + pauseDivWidth / 2 - 20, pauseDivY + 20, 10, pauseDivHeight - 40); // Left bar for Pause
  rect(pauseDivX + pauseDivWidth / 2 + 10, pauseDivY + 20, 10, pauseDivHeight - 40); // Right bar for Pause

  fill(0, 255, 0); // Green for Play
  rect(playDivX, playDivY, playDivWidth, playDivHeight);
  fill(255);
  triangle(playDivX + 30, playDivY + 20, playDivX + 30, playDivY + playDivHeight - 20, playDivX + 70, playDivY + playDivHeight / 2); // Triangle pointing right for Play

  fill(0, 0, 255); // Blue for Loop Once
  rect(loopOnceDivX, loopOnceDivY, loopOnceDivWidth, loopOnceDivHeight);
  fill(255);
  arc(loopOnceDivX + loopOnceDivWidth / 2, loopOnceDivY + loopOnceDivHeight / 2, 60, 60, PI, TWO_PI); // Semi-circle for Loop Once
  triangle(loopOnceDivX + loopOnceDivWidth / 2 + 20, loopOnceDivY + loopOnceDivHeight / 2 - 10, loopOnceDivX + loopOnceDivWidth / 2 + 30, loopOnceDivY + loopOnceDivHeight / 2, loopOnceDivX + loopOnceDivWidth / 2 + 20, loopOnceDivY + loopOnceDivHeight / 2 + 10); // Arrowhead

  fill(0, 0, 128); // Dark Blue for Loop Infinite
  rect(loopInfiniteDivX, loopInfiniteDivY, loopInfiniteDivWidth, loopInfiniteDivHeight);
  fill(255);
  ellipse(loopInfiniteDivX + loopInfiniteDivWidth / 2 - 20, loopInfiniteDivY + loopInfiniteDivHeight / 2, 30, 30); // Left circle for Loop Infinite
  ellipse(loopInfiniteDivX + loopInfiniteDivWidth / 2 + 20, loopInfiniteDivY + loopInfiniteDivHeight / 2, 30, 30); // Right circle for Loop Infinite

  fill(255, 165, 0); // Orange for Fast Forward
  rect(fastForwardDivX, fastForwardDivY, fastForwardDivWidth, fastForwardDivHeight);
  fill(255);
  triangle(fastForwardDivX + 30, fastForwardDivY + 20, fastForwardDivX + 30, fastForwardDivY + fastForwardDivHeight - 20, fastForwardDivX + 70, fastForwardDivY + fastForwardDivHeight / 2); // Triangle pointing right
  triangle(fastForwardDivX + 70, fastForwardDivY + 20, fastForwardDivX + 70, fastForwardDivY + fastForwardDivHeight - 20, fastForwardDivX + 110, fastForwardDivY + fastForwardDivHeight / 2); // Second triangle for Fast Forward

  fill(255, 255, 0); // Yellow for Next Song
  rect(nextDivX, nextDivY, nextDivWidth, nextDivHeight);
  fill(0);
  triangle(nextDivX + 30, nextDivY + 20, nextDivX + 30, nextDivY + nextDivHeight - 20, nextDivX + 70, nextDivY + nextDivHeight / 2); // Triangle pointing right
  rect(nextDivX + 80, nextDivY + nextDivHeight / 2 - 20, 10, 40); // Vertical bar for Next

  fill(75, 0, 130); // Indigo for Shuffle
  rect(shuffleDivX, shuffleDivY, shuffleDivWidth, shuffleDivHeight);
  fill(255);
  line(shuffleDivX + 30, shuffleDivY + 30, shuffleDivX + 70, shuffleDivY + shuffleDivHeight - 30); // Diagonal line for Shuffle
  line(shuffleDivX + 70, shuffleDivY + 30, shuffleDivX + 30, shuffleDivY + shuffleDivHeight - 30); // Cross line for Shuffle

  // Draw the Quit button with the image
  if (quitButtonImage != null) {
    image(quitButtonImage, quitDivX, quitDivY, quitDivWidth, quitDivHeight);
  }
} //End draw
//
void mousePressed() {
  if (mouseX >= stopDivX && mouseX <= stopDivX + stopDivWidth && mouseY >= stopDivY && mouseY <= stopDivY + stopDivHeight) {
    playList[currentSongIndex].pause();
    playList[currentSongIndex].rewind(); // Stop
  }
  if (mouseX >= muteDivX && mouseX <= muteDivX + muteDivWidth && mouseY >= muteDivY && mouseY <= muteDivY + muteDivHeight) {
    playList[currentSongIndex].mute(); // Mute
  }
  if (mouseX >= unmuteDivX && mouseX <= unmuteDivX + unmuteDivWidth && mouseY >= unmuteDivY && mouseY <= unmuteDivY + unmuteDivHeight) {
    playList[currentSongIndex].unmute(); // Unmute the current song
  }
  if (mouseX >= previousDivX && mouseX <= previousDivX + previousDivWidth && mouseY >= previousDivY && mouseY <= previousDivY + previousDivHeight) {
    // Previous Song
    playList[currentSongIndex].close();
    currentSongIndex = (currentSongIndex - 1 + playList.length) % playList.length; // Switch to the previous song
    playList[currentSongIndex].play();

    // Change image based on the current song
    String imagePath = "";
    if (currentSongIndex == 0) {
      imagePath = "images/pvz.jpg";
    } else if (currentSongIndex == 1) {
      imagePath = "images/R.jpg";
    } else if (currentSongIndex == 2) {
      imagePath = "images/plants-vs-zombies-background-i7pf3vxoaxm1mhyw.jpg";
    } else if (currentSongIndex == 3) {
      imagePath = "images/OIP.jpg";
    } else if (currentSongIndex == 4) {
      imagePath = "images/2868226_orig - Copy.jpg"; // Updated fifth song image
    }

    PImage newImage = loadImage(imagePath);
    if (newImage != null) {
      myFirstImage = newImage;
    } else {
      println("Error: Image not found at " + imagePath);
    }
  }
  if (mouseX >= fastRewindDivX && mouseX <= fastRewindDivX + fastRewindDivWidth && mouseY >= fastRewindDivY && mouseY <= fastRewindDivY + fastRewindDivHeight) {
    playList[currentSongIndex].skip(-10000); // Fast Rewind
  }
  if (mouseX >= pauseDivX && mouseX <= pauseDivX + pauseDivWidth && mouseY >= pauseDivY && mouseY <= pauseDivY + pauseDivHeight) {
    playList[currentSongIndex].pause(); // Pause
  }
  if (mouseX >= playDivX && mouseX <= playDivX + playDivWidth && mouseY >= playDivY && mouseY <= playDivY + playDivHeight) {
    playList[currentSongIndex].play(); // Play
  }
  if (mouseX >= loopOnceDivX && mouseX <= loopOnceDivX + loopOnceDivWidth && mouseY >= loopOnceDivY && mouseY <= loopOnceDivY + loopOnceDivHeight) {
    playList[currentSongIndex].loop(1); // Loop Once
  }
  if (mouseX >= loopInfiniteDivX && mouseX <= loopInfiniteDivX + loopInfiniteDivWidth && mouseY >= loopInfiniteDivY && mouseY <= loopInfiniteDivY + loopInfiniteDivHeight) {
    playList[currentSongIndex].loop(); // Loop Infinite
  }
  if (mouseX >= fastForwardDivX && mouseX <= fastForwardDivX + fastForwardDivWidth && mouseY >= fastForwardDivY && mouseY <= fastForwardDivY + fastForwardDivHeight) {
    playList[currentSongIndex].skip(10000); // Fast Forward
  }
  if (mouseX >= nextDivX && mouseX <= nextDivX + nextDivWidth && mouseY >= nextDivY && mouseY <= nextDivY + nextDivHeight) {
    // Next Song
    playList[currentSongIndex].pause(); // Stop the current song
    playList[currentSongIndex].rewind();
    currentSongIndex = (currentSongIndex + 1) % playList.length; // Switch to the next song
    playList[currentSongIndex].play(); // Play the next song

    // Change image based on the current song
    String imagePath = "";
    if (currentSongIndex == 0) {
      imagePath = "images/pvz.jpg";
    } else if (currentSongIndex == 1) {
      imagePath = "images/R.jpg";
    } else if (currentSongIndex == 2) {
      imagePath = "images/plants-vs-zombies-background-i7pf3vxoaxm1mhyw.jpg";
    } else if (currentSongIndex == 3) {
      imagePath = "images/OIP.jpg";
    } else if (currentSongIndex == 4) {
      imagePath = "images/2868226_orig - Copy.jpg"; // Updated fifth song image
    }

    PImage newImage = loadImage(imagePath);
    if (newImage != null) {
      myFirstImage = newImage;
    } else {
      println("Error: Image not found at " + imagePath);
    }
  }
  if (mouseX >= shuffleDivX && mouseX <= shuffleDivX + shuffleDivWidth && mouseY >= shuffleDivY && mouseY <= shuffleDivY + shuffleDivHeight) {
    // Shuffle
    playList[currentSongIndex].close();
    playList[currentSongIndex] = minim.loadFile("Loonboon _ Laura Shigihara.mp3"); // Replace with actual shuffle logic
    playList[currentSongIndex].play();
  }
  if (mouseX >= quitDivX && mouseX <= quitDivX + quitDivWidth && mouseY >= quitDivY && mouseY <= quitDivY + quitDivHeight) {
    exit(); // Quit the application
  }
} //End mousePressed
//
void keyPressed() {
  if (key == 'p') {
    playList[currentSongIndex].play();  // Play audio on 'p' key press
  }
  if (key == 's') {
    playList[currentSongIndex].pause(); // Pause audio on 's' key press
  }
}
//
void stop() {
  for (AudioPlayer player : playList) {
    player.close();
  }
  minim.stop();
  super.stop();
}
// End Main Program