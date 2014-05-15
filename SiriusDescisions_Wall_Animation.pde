import controlP5.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

ControlP5   cp5;
PFont       openSansRegular;
int         twitterInterval = 30000; // 30 seconds
PImage logo; 


// SiriusDecisions brand colors -- RGB FORMULAS ARE OUTDATED
color[] colors = {color(0, 51, 89),    // Dark Blue
                  color(0, 115, 207),  // Blue
                  color(99, 177, 229), // Light Blue
                  color(122, 184, 0),  // Green
                  color(224, 82, 6),   // Orange
                  color(240, 171, 0)}; // Yellow

// Rainbow palette     
color[] rainbowColors = {color(142, 157, 206), //Purple
                         color(121, 175, 224), 
                         color(141, 200, 205),
                         color(182, 207, 88),
                         color(201, 209, 67),
                         color(220, 212, 60),
                         color(242, 212, 53),
                         color(233, 183, 98),
                         color(224, 156, 124)};

GridController grid;
TweetController tweetController;

public void setup(){
  size(displayWidth, int(displayHeight * 0.3), P2D);
  //size(displayWidth, displayHeight, P2D);
  //frame.setBackground(new java.awt.Color(255,0,0));
  hint(ENABLE_STROKE_PURE);
  Ani.init(this);
  float triangleSize = height * 0.1;
  
  // Grid Controller
  grid = new GridController(this, triangleSize);
  grid.build();
  
  // Twitter Controller
  tweetController = new TweetController(twitterInterval);
  
  // Font
  openSansRegular = createFont("OpenSans", 24, true); 
  textFont(openSansRegular);
  
  // Logo
  logo = loadImage("summit-temp-logo.png");
  logo.resize(0, int(height * .263888));
  
  initUI();
}

public void keyPressed() {
  if (keyPressed) {
    if (key == 'd') {
      if(tweetController.displayTweets == false){
        tweetController.displayTweets = true;
      }else {
        tweetController.displayTweets = false;
      }
    } else if (key == 't'){
      if(tweetController.twitterOn == false){
        tweetController.twitterOn = true;
      } else{
        tweetController.twitterOn = false;
      }
    } 
   } // if
} // key pressed

public void draw(){
  background(color(0, 35, 61));
  //logo.resize(int(logo.width * 0.25), int(logo.height * 0.25));
  image(logo, int(width * .018939), int(height * .128787));
  
  
  if(tweetController.displayTweets)
  {
      tweetController.draw();
  }
  
   for(int i=0; i< grid.triangles.size(); i++){
     grid.triangles.get(i).draw();
   }
}


// ---- UI ----
void initUI() {

  cp5 = new ControlP5(this);
  cp5.enableShortcuts();
  cp5.hide();
  
  Range range;
  Range exitRange;

  //cp5.addFrameRate().setInterval(10).setPosition(0, height * 0.2);

  cp5.addSlider("Font_Size")
     .setRange(int(height * 0.01), int(height * 0.10))
     .setValue(int(height * 0.03))
     .setPosition(width * 0.35, height * 0.02)
     .setSize(int(width * 0.35), int(height * 0.05));
  
  cp5.addSlider("Tweet_Spacing")
     .setRange(int(height * 0.01), int(height * 0.20))
     .setValue(15)
     .setPosition(width * 0.35, height * 0.13)
     .setSize(int(width * 0.15), int(height * 0.05));

  cp5.addSlider("Tweet_Duration_Sec")
     .setRange(5,60)
     .setValue(20)
     .setPosition(width * 0.35, height * 0.24)
     .setSize(int(width * 0.15), int(height * 0.05));

    cp5.addSlider("Tweet_Top_Margin")
     .setRange(int(height * 0.05), int(height * 0.5))
     .setValue(int(height * 0.1))
     .setPosition(width * 0.35, height * 0.35)
     .setSize(int(width * 0.15), int(height * 0.05));

  
  cp5.addRange("Triangle Entrance (in secs.)")
             // disable broadcasting since setRange and setRangeValues will trigger an event
             .setBroadcast(false) 
             .setPosition(width * 0.02, height * 0.02)
             .setSize(int(width * 0.20), int(height * 0.08))
             .setHandleSize(20)
             .setRange(1,120)
             .setRangeValues(grid.minEnterDuration,grid.maxEnterDuration)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true)
             .setMin(1)
             .setMax(120);
}

void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("Triangle Entrance (in secs.)")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
      grid.minEnterDuration = int(theControlEvent.getController().getArrayValue(0));
      grid.maxEnterDuration = int(theControlEvent.getController().getArrayValue(1));
  } 
}

void Font_Size(float value){
    tweetController.set_font_size(int(value));  
    //println(tweetController.font_size());
  }
  
void Tweet_Duration_Sec(float value){
    tweetController.set_duration(int(value)*1000);
}

void Tweet_Spacing(float value){
    tweetController.set_spacing(value);
}

void Tweet_Top_Margin(float value){
    tweetController.set_top_margin(value);
}
