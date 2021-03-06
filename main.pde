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
  
  PFont font = createFont("Ms Gothic",80,true);
  textFont(font);
  
  
  float th = textAscent() + textDescent();
  float margin = 12;
  if (tweets.size() > 0) {
    Tweet t = tweets.get(tweets.size() - 1); // latest tweet
    float tw = width - t.profileImage.width - margin * 3;
    
    String tt = t.text;
    tt = tt.replaceAll("指定するハッシュタグ", "");
    
    if (tt.length() > 15) {
      tx -= tt.length()
    } else {
      tx -= 7;
    }
    
    
    text(t.name, tx, th * 3,tw, height - th * 4);
    text(tt, tx, th * 4, tw, height - th * 4);
    
    
  }
  server.sendScreen();  
}

class MyStatusListener extends StatusAdapter {
  public void onStatus(Status s) {
    tweets.add(new Tweet(s));
  }
}
