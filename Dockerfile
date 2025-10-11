# ベースイメージとして、軽量なJava 21のJDKを使用
FROM openjdk:21-slim

# wgetとsedをインストール
RUN apt-get update && apt-get install -y wget sed

# Tomcatをダウンロードして解凍
RUN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.20/bin/apache-tomcat-10.1.20.tar.gz && \
    tar xzvf apache-tomcat-10.1.20.tar.gz -C /opt/ && \
    rm apache-tomcat-10.1.20.tar.gz

# Tomcatのディレクトリ名を変更して簡潔にする
RUN mv /opt/apache-tomcat-10.1.20 /opt/tomcat

# server.xmlを修正し、ポートを環境変数から読み込むように設定する
RUN sed -i 's/port="8080"/port="${PORT}"/' /opt/tomcat/conf/server.xml

# アプリケーションのWARファイルをTomcatのwebappsディレクトリにコピー
COPY compliment-cascade.war /opt/tomcat/webapps/ROOT.war

# Tomcatのポートを公開
EXPOSE 8080

# Tomcatを起動するコマンド
CMD ["/opt/tomcat/bin/catalina.sh", "run"]