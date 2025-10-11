# Tomcat公式イメージをベースとして使用
FROM tomcat:10.1-jdk21-temurin

# アプリケーションのWARファイルをTomcatのwebappsディレクトリにコピー
COPY compliment-cascade.war /usr/local/tomcat/webapps/ROOT.war