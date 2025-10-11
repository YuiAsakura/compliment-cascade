# ベースイメージとして、軽量なJava 21のJDKを使用
FROM openjdk:21-slim

# wgetをインストール
RUN apt-get update && apt-get install -y wget

# Tomcatをダウンロードして解凍
RUN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.20/bin/apache-tomcat-10.1.20.tar.gz && \
    tar xzvf apache-tomcat-10.1.20.tar.gz -C /opt/ && \
    rm apache-tomcat-10.1.20.tar.gz

# Tomcatのディレクトリ名を変更して簡潔にする
RUN mv /opt/apache-tomcat-10.1.20 /opt/tomcat

# アプリケーションのWARファイルをTomcatのwebappsディレクトリにコピー
COPY compliment-cascade.war /opt/tomcat/webapps/ROOT.war

# Tomcatのポートを公開
EXPOSE 8080

# Tomcatのポートを環境変数から設定
ENV CATALINA_OPTS="-Dserver.http.port=$PORT"

# Tomcatを起動するコマンド
ENTRYPOINT ["/opt/tomcat/bin/catalina.sh"]
CMD ["run"]