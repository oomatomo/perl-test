
## Perlのテスト

### 利用方法

```
$ carton install
$ carton exec -- prove -r *.t
```

### 各ファイルの説明

#### *.t

テストファイル

#### cpanfile

carton でモジュールを管理しています。

#### fixture.pl

ローカルのDB(host=localhost: port=3306: dbname=test)

にアクセスしてYAMLファイルを生成します

#### test.sql

テスト用のSQLです

#### schema.yaml fixture.yaml

test.sqlから抽出したYAMLファイルです

