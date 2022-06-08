FROM nginx:1.15.8

# include用のディレクトリない削除
RUN rm -f /etc/nginx/conf.d/*

# nginxの設定ファイルをコンテナにコピー
ADD nginx.conf /etc/nginx/conf.d/workouter.conf

# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
