# README

## サービス内容

全国のトレーニーと繋がれるSNS。

誰かと合トレしたい、情報共有したい

そんなトレーニーの手助けとなるサービスです。

## デザイン

https://www.figma.com/file/j04vMjpvVODBbWdRzT0KiT/Workouter?node-id=0%3A1

## 機能

1. アカウント登録
2. いいね
3. フォロー
4. チャット
5. ユーザー検索

## 環境

- OS
  - Mac

- インフラ
  - Docker
  - MySql5.7 
  - Nginx 
  - EC2

- 言語
  - Ruby(3.0.2)
  - Javascript

- フレームワーク
  - Ruby on rails(6.1.4)

## アピールポイント

1. デザイン作成にFigma使用
2. いいね、メッセージ送信、フォロー追加（削除）時にAjax使用し、UX向上
3. WebサーバーにNginxを使用し、高速化
4. 本番環境にAWS(EC2)使用
5. こまめにブランチ切る、コミットする、リファクタリング

## 今後アップデートしていきたいこと

1. 利用ジムにGoogle Maps API 導入
2. グループチャット機能
3. インスタグラムの様な投稿機能
4. スマホ対応、アプリ化
