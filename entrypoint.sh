# server.pidファイルが存在する場合に、サーバーが再起動しないように
#!/bin/bash

# set shel の設定を確認、変更
# command errorが発生したらshell終了
set -e

# server起動時に既存のPIDが残っていると起動しないので、削除
rm -f /workouter/tmp/pids/server.pid

exec "$@"
