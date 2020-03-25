import codeanticode.syphon.*;
SyphonServer server;

import twitter4j.*;
import twitter4j.api.*;
import twitter4j.auth.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.management.*;
import twitter4j.util.*;
import twitter4j.util.function.*;

String consumerKey = "";
String consumerSecret = "";
String accessToken = "";
String accessTokenSecret = "";

class Tweet {
  long id;
  String text;
  String name;
  String screenName;
  PImage profileImage;
  public Tweet(Status s) {
    id = s.getId();
    text = s.getText();    
    User u = s.getUser();
    name = u.getName();
    screenName = u.getScreenName();
    profileImage = loadImage(u.getProfileImageURL());
  }
}

Twitter twitter;

ArrayList<Tweet> tweets;
float tx = 1920;
float y = 500;

void settings() {
  size(1920, 1080, P3D);
  PJOGL.profile=1;
}

void setup() {
  size(1920, 1080);
  tweets = new ArrayList();
  ConfigurationBuilder builder = new ConfigurationBuilder();
  builder.setOAuthConsumerKey(consumerKey);
  builder.setOAuthConsumerSecret(consumerSecret);
  builder.setOAuthAccessToken(accessToken);
  builder.setOAuthAccessTokenSecret(accessTokenSecret);
  TwitterStreamFactory factory = new TwitterStreamFactory(builder.build());
  TwitterStream stream = factory.getInstance();
  stream.addListener(new MyStatusListener()); 
  stream.filter("#TMF3");

  server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  background(0);
  fill(255);
  PFont font = createFont("Ms Gothic", 130, true);
  textFont(font);

  if (tweets.size() > 0) {
    Tweet t = tweets.get(tweets.size() - 1); 

    String tt = t.text;
    tt = tt.replaceAll("#TMF3", "");

    tx -= 7.5;


    text(tt, tx, y);

    //text(t.name, tx+35, y-83);  
  }
  server.sendScreen();
}

class MyStatusListener extends StatusAdapter {
  public void onStatus(Status s) {
    delay(5000);
    tweets.add(new Tweet(s));
    tx = 1920;
    y = random(70, 950);
  }
}
