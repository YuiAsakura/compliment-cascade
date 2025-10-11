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

		/**
		 * 褒め言葉の滝を生成するスクリプト
		 */
		var compliment = new Object();
		
		// JSPから渡されたcomplimentListを使用する
		compliment.list = complimentList;
		
		compliment.set = function() {
			// <span>要素を生成
			var span = document.createElement("span");
			// クラス名を指定
			span.className = "compliment";
			// ランダム位置に配置
			span.style.left = ( Math.random() * 100 ) + "%";
			span.style.top = ( Math.random() * 100 ) + "%";
			// リスト中の文字列をランダムに表示
			span.textContent = compliment.list[ Math.floor( Math.random()*compliment.list.length) ];
			
			// アニメーション終了後に要素を削除する処理を追加
			span.addEventListener('transitionend', function(e) {
				// opacityプロパティの変化が完了した時だけ処理を実行
				if (e.propertyName === 'opacity') {
					this.remove(); // 要素をDOMから削除
				}
			});
			
			// body要素に<span>を追加
			document.body.appendChild( span );
		
			// 要素がDOMに追加された直後に'show'クラスを追加
			// 少し遅延させることで、transitionが有効になる
			setTimeout(function(){
				span.classList.add('show');
			}, 10);
		};
		
		// ページの読み込みが完了したらタイマーを起動する
		window.addEventListener('DOMContentLoaded', (event) => {
			// 500ミリ秒間隔で実行
			compliment.tmr = setInterval( compliment.set, 500 );
		}); 
	</script>
	<script src="style.css"></script>
</body>
</html>