#!/bin/sh

# エラーがあったらシェルスクリプトの実行を止める
set -e

# パイプラインの左が失敗したらスクリプトを停止する
set -o pipefail

# GitHub
cp GitHubClient/Secrets/PrivateKey_template.swift GitHubClient/Secrets/PrivateKey.swift
# ACCESS_TOKENを置換する（iで上書きファイル指定, eで処理内容の指定, -i ''でバックアップファイルの拡張子を指定しない）
sed -i '' -e "s/\[GITHUB_API_KEY\]/$ACCESS_TOKEN/" GitHubClient/Secrets/PrivateKey.swift
# ClientIDを置換する
sed -i '' -e "s/\[GITHUB_CLIENT_ID\]/$CLIENT_ID/" GitHubClient/Secrets/PrivateKey.swift
# ClientSecretを置換する
sed -i '' -e "s/\[GITHUB_CLIENT_SECRET\]/$CLIENT_SECRET/" GitHubClient/Secrets/PrivateKey.swift