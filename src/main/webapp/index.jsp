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
	<script>
		// JSPが動的に生成する部分
		const complimentList = [
			<%
				// サーブレットから渡されたリストをリクエスト属性から取得
				List<String> compliments = (List<String>) request.getAttribute("compliments");

				// リストがnullでなく、要素が存在する場合に処理
				if (compliments != null) {
					for (int i = 0; i < compliments.size(); i++) {
						out.print("\"" + compliments.get(i) + "\"");
						if (i < compliments.size() - 1) {
							out.print(", ");
						}
					}
				}
			%>
		];
	</script>
	<script src="script.js"></script>
</body>
</html>