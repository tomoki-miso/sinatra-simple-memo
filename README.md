# sinatra-simple-memo

Sinatra を使って Web アプリケーションの基本を理解するためのシンプルなメモアプリです。

## 必要環境

- Ruby
- Bundler
- PostgreSQL

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

3. PostgreSQL を起動し、`memos` テーブルを作成する

    アプリ起動時にも `db/schema.sql` が自動実行されますが、手動で適用する場合は次のコマンドを使います。

    ```sh
    psql -d postgres -f db/schema.sql
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

メモのデータは PostgreSQL の `memos` テーブルに保存されます。スキーマ定義は [`db/schema.sql`](db/schema.sql) を参照してください。

## URI 設計

REST に倣った URI 設計を採用しています。

| メソッド | パス               | 説明                 |
| -------- | ------------------ | -------------------- |
| GET      | `/memos`           | 一覧表示             |
| GET      | `/memos/new`       | 新規作成フォーム     |
| POST     | `/memos`           | 新規作成             |
| GET      | `/memos/:id`       | 詳細表示             |
| GET      | `/memos/:id/edit`  | 編集フォーム         |
| PATCH    | `/memos/:id`       | 更新                 |
| DELETE   | `/memos/:id`       | 削除                 |
