<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String javaVersion = System.getProperty("java.version");
  String fileEncoding = System.getProperty("file.encoding");
  String serverInfo = application.getServerInfo();
  int servletMajor = application.getMajorVersion();
  int servletMinor = application.getMinorVersion();
  String contextPath = request.getContextPath();
  boolean javaOk = javaVersion != null && (javaVersion.startsWith("11.") || javaVersion.startsWith("21."));
  boolean encOk = "UTF-8".equalsIgnoreCase(fileEncoding);
  boolean servletOk = servletMajor >= 4 && servletMinor >= 0;
%>
<%! String badge(boolean ok) { return ok ? "<span class='badge ok'>OK</span>" : "<span class='badge ng'>NG</span>"; } %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>環境チェックダッシュボード</title>
  <style>
    body { background: #f0f0f0; font-family: Arial, sans-serif; }
    .badge.ok { color: green; font-weight: bold; }
    .badge.ng { color: red; font-weight: bold; }
  </style>
</head>
<body>
  <h2>環境チェック</h2>
  <p>Java: <%= badge(javaOk) %> (v<%= javaVersion %>)</p>
  <p>Servlet: <%= badge(servletOk) %> (v<%= servletMajor %>.<%= servletMinor %>)</p>
  <p>Encoding: <%= badge(encOk) %> (<%= fileEncoding %>)</p>
  <p>Context: <%= contextPath %></p>
  <p>Server: <%= serverInfo %></p>
</body>
</html>
