# sinatra-simple-memo

Sinatra を使って Web アプリケーションの基本を理解するためのシンプルなメモアプリです。

## 必要環境

- Ruby
- Bundler

## セットアップ

1. リポジトリをクローンする

    ```sh
    git clone https://github.com/tomoki-miso/sinatra-simple-memo.git
    cd sinatra-simple-memo
    ```

2. 依存 gem をインストールする

    ```sh
    bundle install
    ```

## 起動方法

以下のコマンドでアプリケーションを起動します。

```sh
bundle exec ruby app.rb
```

起動後、ブラウザで http://localhost:4567 にアクセスするとメモ一覧が表示されます。

## 機能

- メモ一覧の表示
- メモの新規作成
- メモの詳細表示
- メモの編集
- メモの削除

メモのデータは `memos.json` に保存されます。
