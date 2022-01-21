## Prerequisites

- 以下のコマンドをインストールしておく
  - gcloud
  - kubectl
- gcloud auth で利用するプロジェクトの認証を行なっておく

## 初期設定

```sh
# docker registryの作成やdocker imageのpushなどを行う。初回だけでOK
$ make init
```

## クラスタ立ち上げ&アプリのデプロイ

```sh
# クラスタを作成してアプリをクラスタのdev環境へデプロイする
$ make ENV=dev
```

## dev 環境へのアプリのデプロイ

```sh
$ make deploy ENV=dev
```

## クラスタ削除

```sh
$ make teardown
```
