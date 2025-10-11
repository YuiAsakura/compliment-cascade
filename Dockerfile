# ステージ1: アプリケーションをビルド
FROM maven:3.8.3-openjdk-17 AS builder
# アプリケーションのコードをコピーし、WARファイルをビルド
COPY . .
RUN mvn clean package

# ステージ2: TomcatとNGINXを組み合わせる
FROM openjdk:21-slim
# NGINXをインストール
RUN apt-get update && apt-get install -y nginx

# Tomcatをダウンロードして解凍
RUN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.20/bin/apache-tomcat-10.1.20.tar.gz && \
    tar xzvf apache-tomcat-10.1.20.tar.gz -C /opt/ && \
    mv /opt/apache-tomcat-10.1.20 /opt/tomcat && \
    rm apache-tomcat-10.1.20.tar.gz

# WARファイルをTomcatにコピー
COPY --from=builder /target/compliment-cascade.war /opt/tomcat/webapps/ROOT.war

# NGINXの設定ファイルをコンテナにコピー
COPY nginx.conf /etc/nginx/nginx.conf

# コンテナが起動したときにNGINXとTomcatの両方を起動
CMD service nginx start && /opt/tomcat/bin/catalina.sh run