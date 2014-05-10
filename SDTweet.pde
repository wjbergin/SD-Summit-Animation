class SDTweet {
  
  // Tweet data
  String profile_image_url;
  String tweet;
  String createdAt;
  String name;
  String userName;
  String tweetTextWithName;
  long id;
  boolean displayed = false;
  int start_time;
  
  // Tweet formatting
  color textColor;
  //int font_size = 10;

  
  Point origin;
  float timeToDeath = 0;
  
  //Parent
  TweetController controller;
  
  SDTweet(TweetController _controller, String _profile_image_url, String _tweet, String _createdAt, String _name, long _id){
    profile_image_url = _profile_image_url;
    tweet = _tweet;
    createdAt = _createdAt;
    name = _name;
    id = _id;
    controller = _controller;
    textColor = tweetTextColor(_name, controller.employees);
    origin = new Point(width/2, 20);
    tweetTextWithName = _tweet + " \u2013 " + _name;
  }
  
 void transition_out(){
   Ani.to(this, 2, "x", width + 100, Ani.EXPO_OUT);
 }

 void draw(){
    textFont(openSansRegular);
    textSize(controller.font_size());
    float tWidth = textWidth(tweetTextWithName);
    //float tHeight = textAscent();
    
    fill(textColor);
    //fill(color(255,255,255));
    textAlign(RIGHT);
    text(tweetTextWithName, width - tWidth - 20, origin.y, tWidth, height * 0.2);
  
  } //draw
  
  color tweetTextColor(String _name, String[] _employeeList){
    color c;
     if(name.equals("SiriusDecisions")){
      // Tweet is from SiriusDecisions
      c = colors[3];
    } else if (inEmployeeList(_name, _employeeList)){
      // Tweet is from an employee
      c = colors[2];
    } else {
      // Tweet is from external party
      c = colors[2];
    }
    return c;
  }

  boolean inEmployeeList(String _name, String[] _array){
    boolean result;
    
    for(int i=0; i <= _array.length-1; i++){
      if(_array[i].equals(_name)){
        return true;
      }
    }
    return false;
  }


}
