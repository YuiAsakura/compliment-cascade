# ベースイメージとして、軽量なJava 21のJDKを使用
FROM openjdk:21-slim

# Tomcatをダウンロードして解凍
# この例ではTomcat 10を使用していますが、最新版に合わせてもOKです
RUN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.20/bin/apache-tomcat-10.1.20.tar.gz && \
    tar xzvf apache-tomcat-10.1.20.tar.gz -C /opt/ && \
    rm apache-tomcat-10.1.20.tar.gz

# Tomcatのディレクトリ名を変更して簡潔にする
RUN mv /opt/apache-tomcat-10.1.20 /opt/tomcat

# アプリケーションのWARファイルをTomcatのwebappsディレクトリにコピー
# ファイル名はあなたのWARファイル名に合わせる必要があります
COPY target/compliment-cascade.war /opt/tomcat/webapps/ROOT.war

# Tomcatのポートを公開
EXPOSE 8080

# Tomcatを起動するコマンド
CMD ["/opt/tomcat/bin/catalina.sh", "run"]