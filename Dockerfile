# Tomcat公式イメージをベースとして使用
FROM tomcat:10.1-jdk21-temurin

# アプリケーションのWARファイルをTomcatのwebappsディレクトリにコピー
COPY compliment-cascade.war /usr/local/tomcat/webapps/ROOT.war

# Tomcatをフォアグラウンドで起動し、ポートを環境変数から設定
ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh"]
CMD ["run", "-Dserver.port=${PORT}"]