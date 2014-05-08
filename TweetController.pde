/*
* oauthP5 Twitter2LegExample
*
* Twitter offers the ability for you to retrieve a single access token 
* (complete with oauth_token_secret) from your application detail page found 
* on dev.twitter.com/apps. This is ideal for applications with single-user
* use cases. By using a single access token, you don't need to implement 
* the entire OAuth token acquisition dance. Instead, you can pick up from 
* the point where you are working with an access token to make signed 
* requests for Twitter resources.
* Official guide from Twitter: 
* https://dev.twitter.com/docs/auth/oauth/single-user-with-examples
*
* by New York Times R&D Lab (achang), 2012
* www.nytlabs.com/oauthp5
*
*/

import oauthP5.apis.TwitterApi;
import oauthP5.oauth.*;
import java.util.LinkedList;
import java.util.regex.*;
//import org.json.JSONArray;


class TweetController {
 
  private boolean  twitterOn;
  private boolean  displayTweets = false;
  private int      numTweetsToShow = 5;
  private int      numDisplayedTweets = 0;
  private int      tweet_duration = 20000;
  private float    spacing = 20;
  private float    startY = height * 0.1;
  private int      range = -1;
  private int      num_tweets;
  private int      max_display = 5;
  private float    font_size = 10;

  private TweetThread  thread;
  
  ArrayList<SDTweet> tweetList = new ArrayList<SDTweet>();
  
  // TODO: Add employees
  private String[] employees = {"Tony Yang", 
                                "Jim Ninivaggi", 
                                "Brad Gillespie", 
                                "Megan Heuer", 
                                "Matt Senatore",
                                "Jay Gaines"};
 
  TweetController(int wait){
    twitterOn = false;
    displayTweets = false;
    thread = new TweetThread(wait);  // new thread every N milliseconds
    thread.start();
  }
  
  //Parse tweets and add to list of tweets
  void parseTweets(JSONArray tweets){

    
    if (tweets.size() != 0){
      for(int i=tweets.size()-1; i > 0; i--)
      //for(int i=0; i<= tweets.size()-1; i++)
      {
        JSONObject tweet = tweets.getJSONObject(i);
        JSONObject user = tweet.getJSONObject("user");
        String profileImage = user.getString("profile_image_url_https");
        String name = user.getString("name");
        long id = Long.parseLong(tweet.getString("id_str"));
        String text = formatText(tweet.getString("text"));
        String created = tweet.getString("created_at");
        
        SDTweet newTweet = new SDTweet(this, profileImage, text, created, name, id);
        tweetList.add(0, newTweet);
      }
    }
    
    for(int i=0; i <= tweetList.size() - 1; i++){
      SDTweet t = tweetList.get(i);
      println(i + "  created:  " + t.createdAt + " " + t.tweet);
    }
    
} // parseTweets

  private String formatText(String commentstr)
    {
        String commentstr1=commentstr;
        String urlPattern = "((https?|ftp|gopher|telnet|file|Unsure|http):((//)|(\\\\))+[\\w\\d:#@%/;$()~_?\\+-=\\\\\\.&]*)";
        Pattern p = Pattern.compile(urlPattern,Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(commentstr1);
        int i=0;
        while (m.find()) {
            commentstr1=commentstr1.replaceAll(m.group(i),"").trim();
            i++;
        }
        
        commentstr1 = commentstr1.replace("&amp;", "&")
                                 .replace("\n", " ");
        
        return commentstr1;
    }

  public void set_font_size(float size){
      font_size = size;
  }
  
  public float font_size(){
      return font_size;
  }
  
  public void set_duration(int value){
      tweet_duration =  int(value);
  }
  
  public int duration(){
      return tweet_duration;
  }
  
  public float spacing(){
      return spacing;
  }
  
  public void set_spacing(float value){
      spacing = value;
  }

  // Display tweets
  void draw(){
    
      if(thread.available()){
        parseTweets(thread.fetch_tweets());
      }
      
      // Update tweets
      if (tweetList.size() != 0)
      {
        for(int i = tweetList.size()-1; i >= 0; i--)
        {
           SDTweet tweet = tweetList.get(i);
           //println("duration: " + tweet_duration);
           if (tweet.displayed == true && millis() - tweet.start_time >= tweet_duration)
           {
             tweetList.remove(i);
           }
        }
      }
      

      if (tweetList.size() >= max_display){
          num_tweets = max_display;
      }
      else if (tweetList.size() >= 0){
         num_tweets = tweetList.size(); 
      } 
      else {
       num_tweets = 0; 
      }
    
      

      // draw tweets
      if(tweetList.size() != 0)
      {
        for(int i=tweetList.size()-1, j=0; i > (tweetList.size() - 1) - num_tweets; j++, i--)
        {
          //println("tweetList.size:  " + tweetList.size());
          //println("num tweets:  " + num_tweets);
          //println("i:  " + i);
          SDTweet tweet = tweetList.get(i);
          if (tweet.displayed == true)
          {
              tweet.origin.y = j * spacing + startY;
              tweet.draw();
          }
          else 
          {
            tweet.displayed = true;
            tweet.start_time = millis();
            tweet.origin.y = j * spacing + startY;
            tweet.draw();
          }
        }
      }
  } // draw
  
} // TweetController
