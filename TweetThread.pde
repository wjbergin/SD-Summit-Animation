import oauthP5.apis.TwitterApi;
import oauthP5.oauth.*;

class TweetThread extends Thread {
  
  private boolean available;
  private boolean running;
  private int wait;
  private long since_id = 0;
  private long max_id = 0;
  private int count = 10;
  public JSONArray tweets;
  
  OAuthService service;
  OAuthRequest request;

  final String CONSUMER_KEY = "8Jg8Vc2RYzUUJS55jJeg";
  final String CONSUMER_SECRET = "1JwAJY6AWQB6IYzs3dG2pj8iKWcDHOFL3bJ5gizYE";
  final String ACCESS_TOKEN = "213483290-6WsXcJlme7IaeVlwrkI2ZDmZtxOlOn2V34QP6dpf";
  final String ACCESS_TOKEN_SECRET = "3H6zTzxLmLwDA25HBep7xrjr9LDfKHuUl1vOhQPESWR4s";
  
  //Base query URL and query
  String baseSearchURL = "https://api.twitter.com/1.1/search/tweets.json";
  String search_query = "?q=%23God";
  /* String search_query = "?q=-RT%23SDSummit"; */
  // String test_search = "?q=love";
  
  
  TweetThread(int w){
    init();
    wait = w;
    running = false;
    available = false;
  }

  // Create service
  void init(){
    service = new ServiceBuilder()
    .provider(TwitterApi.class)
    .apiKey(CONSUMER_KEY)
    .apiSecret(CONSUMER_SECRET)
    .build();
  }  
  
  // Overriding "start()"
  public void start ()
  {
    // Set running equal to true
    running = true;
    // Print messages
    System.out.println("Starting thread (will execute every " + (wait/1000) + " seconds.)"); 
    // Do whatever start does in Thread, don't forget this!
    super.start();
  }
  
  // We must implement run, this gets triggered by start()
  public void run ()
  {
    while (running){
      System.out.println("Reloading . . ."); 
      check();
      // Ok, let's wait for however long we should wait
      try {
        sleep((long)(wait));
      } 
      catch (Exception e) {
      }
    }
  }
  
  // Our method that quits the thread
  public void quit()
  {
    System.out.println("Quitting."); 
    running = false;  // Setting running to false ends the loop in run()
    // We used to need to call super.stop()
    // We don't any more since it is deprecated,
    // see: http://java.sun.com/j2se/1.5.0/docs/guide/misc/threadPrimitiveDeprecation.html
    // super.stop();
    // Instead, we use interrupt, in case the thread is waiting. . .
    super.interrupt();
  }
  
  //Form query and make request
  private synchronized void check(){
    
    try{

    String query; 

    if(since_id == 0) 
    {
      String year = String.valueOf(year()); 
      String month = String.valueOf(month());
      String day = String.valueOf(day()-1);
      String today = year + "-" + month + "-" + day;

      // Query for tweets starting today
      query = baseSearchURL + search_query + "+since%3A" + today + "&result_type=recent&count=" + count;
      // println("(1) Query: " + query);
    } 
    else 
    {
      query = baseSearchURL + search_query + "&since_id=" + since_id + "&result_type=mixed&count=" + count;
      // println("(2) Query:" + query);
    }
    
    request = new OAuthRequest(Verb.GET, query);
    service.signRequest(new Token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET), request);
    Response response = request.send();
    
    JSONObject results = JSONObject.parse(response.getBody());
    tweets = results.getJSONArray("statuses");
        
    // Get search metadata
    JSONObject metadata = results.getJSONObject("search_metadata");
    since_id = Long.parseLong(metadata.getString("max_id_str"));

    available = true;
    notifyAll();
    } catch (Exception e) {
      System.out.println("Error requesting tweets: " + e);
    }
  }
  
  public boolean available() {
    return available;
  }
  
  public synchronized JSONArray fetch_tweets(){
      available = false;
      notifyAll();
      return tweets;
  }

} //class
