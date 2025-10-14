<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>compiment-cascade</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<% String message = (String) request.getAttribute("message"); %>
	<% if (message != null) { %>
    	<div class="compliment"><%= message %></div>
	<% } %>
	<script>
		// Javaから渡された褒め言葉リストをJavaScriptの変数に格納
		const complimentList = [
			<%
				// サーブレットから渡されたリストをリクエスト属性から取得
				List<String> compliments = (List<String>) request.getAttribute("compliments");
				
				// リストがnullでなく、要素が存在する場合に処理
				if (compliments != null) {
					for (int i = 0; i < compliments.size(); i++) {
						// 各単語をJSON形式の文字列（ダブルクォーテーションで囲む）で出力
						out.print("\"" + compliments.get(i) + "\"");
						
						// リストの最後の要素以外はカンマで区切る
						if (i < compliments.size() - 1) {
							out.print(", ");
						}
					}
				}
			%>
		];
	</script>
	<script src="./script.js"></script>
	
	<div  class="compliment-input-container">
		<form action="<%= request.getContextPath() %>/ComplimentServlet" method="post">
  			<input type="text" class="compliment-textbox" name="compliment"  maxlength="10" placeholder="だれかをほめる">
  			<button type="submit" class="btn-insert-compliment">></button>
		</form>
	</div>
</body>
</html>