こちらは「推し♡だいありー」のバックエンドのリポジトリになります。

# サービス名：　推し♡だいありー

## サービス概要

アイドルファンの人が推しと撮ったチェキや写メ、その日あった出来事、日付、会場を日記として記録していくサービス

メンバー一人一人との思い出をいつでも簡単に振り返ることができる。

## 実際に作成した推しメンとの日記

以下のように日記のような形で推しメンとの思い出をメンバーごとに記録していく。　
<div align="center">
<img width="428" alt="スクリーンショット 2022-06-29 19 25 11" src="https://user-images.githubusercontent.com/71915489/176414909-346fb442-41c7-4ee1-bd14-2e3d3f32dbfc.png">
</div>

## ER図

![ER_figure 2 drawio](https://user-images.githubusercontent.com/71915489/176408993-afc680e7-c584-4245-8cdb-178c367671bd.png)



## 実装済みの機能

### 一般ユーザー
**認証**
- 新規登録、ログイン機能
- ソーシャルログイン機能
  
**メイン機能**
- 推しメンを登録する機能
- 推しメンとの思い出を日記にして登録する機能
- 推しメンの名前で変化する動的OGP画像を作成してツイートできる機能
- 撮ったチェキの枚数を記録していく機能



## 実装予定機能

- チェキを誰と何枚撮ったか円グラフに表示されていく機能
- 日記を記録した日にちがカレンダーに表示される機能
- 出会って何日経ったか記録していく機能
- 気に入ったユーザーをフォローする機能
- フォローしたユーザーの日記がタイムラインに流れる機能
- 日記にコメントがあった時に通知がくる機能
- 他のユーザーの日記にコメントする機能


### 管理ユーザー
- 一般ユーザーを管理する機能
- ユーザーの日記を管理する機能
- 運営からメッセージを送れる機能


## なぜこのサービスを作りたいのか？
アイドルとの思い出をずっと保存しておきたい。
チェキや写メをイベント名、日付、会場と一緒に日記としてメンバーごとに残せるサービスはずっと欲しいと思っていた。
同じように思っているアイドルファンの人が多いので自分が作りたい。
アイドルファンの人、みんなが使うサービスを作りたい。

## 需要

アイドルファンの人にアンケートを取った結果需要はありそう。

<img width="624" alt="スクリーンショット 2022-04-04 13 40 54" src="https://user-images.githubusercontent.com/71915489/161475165-2cff2c34-c381-41ee-be97-0bab39e0fd2d.png">

# スケジュール
## 4/21締切
- ER図完成
- 新規登録機能、ログイン機能を実装（auth0でローカルで実装済み）
- バックエンドに自動テスト、自動rubocopチェックをCircleCIで構築（実装済み）
- フロントエンドをAWSのS3に、バックエンドをECSに自動デプロイする仕組みをCircleCIで構築(技術調査中)

## 5/21締切
技術調査、および以下の機能実装してMVPリリース
### 一般ユーザー
**認証**
- 新規登録、ログイン機能
- ソーシャルログイン機能

**メイン機能**
- 推しメンを登録する機能
- 推しメンとの思い出を日記にして登録する機能
- 日記ごとに動的OGP画像を作成してツイートできる機能(画像にメンバーの名前入れたい)
- 他のユーザーの日記にコメントする機能
- 撮ったチェキの枚数を記録していく機能

### 管理ユーザー
- 管理ユーザーログイン機能
- 一般ユーザーを管理する機能
- ユーザーの日記を管理する機能

## 6/21締切

以下の機能を追加で実装して本リリース
- 日記を記録した日にちがカレンダーに表示される機能
- 出会って何日経ったか記録していく機能
- チェキを誰と何枚撮ったか円グラフに表示されていく機能
- 気に入ったユーザーをフォローする機能
- フォロしたユーザーの日記がタイムラインに流れる機能
