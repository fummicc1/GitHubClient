#!/bin/sh

# エラーがあったらシェルスクリプトの実行を止める
set -e

# パイプラインの左が失敗したらスクリプトを停止する
set -o pipefail


# GitHubのプライベートキーを置換する
cat GitHubClient/Secret/PrivateKey_template.swift | sed -e "s/[GITHUB_API_KEY]/$ACCESS_TOKEN/g" > GitHubClient/Secret/PrivateKey.swift