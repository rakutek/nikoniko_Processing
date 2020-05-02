Twitterで指定しした文字列を含むツイートをAPIから取得し、某動画サイト風にツイート内容をランダムなy座標に流します。


![nikoniko.gif](./nikoniko.gif)

ここにTwitterで申請したキーを入力

```test.pde
String consumerKey = "";
String consumerSecret = "";
String accessToken = "";
String accessTokenSecret = "";
```

ここに文字を入力することで、指定した文字列を含むツイートを収集します


文字を名が荒れる長さが固定で速度が固定で、
速度で文字列の長さで流れる速度を


取得した文字列の長さが大きければ速く、短ければ遅く流れるようにしてメインの映像の邪魔にならないようになっています


```test.pde
tt = tt.replaceAll("指定するハッシュタグ", "");
```
SyphonServerとして動作するようにしています。  
WindowsであればNDIかSpoutのライブラリでまかなえそう？
