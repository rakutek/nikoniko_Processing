
![nikoniko.gif](./nikoniko.gif)

Twitterで申請したキーを入力してくだい

```test.pde
String consumerKey = "";
String consumerSecret = "";
String accessToken = "";
String accessTokenSecret = "";
```

ここに文字を入力することで、指定した文字列を含むツイートを収集します

```test.pde
tt = tt.replaceAll("指定するハッシュタグ", "");
```
SyphonServerとして動作するようにしています。
WindowsであればNDIかSpoutのライブラリでなんとかしましょう
