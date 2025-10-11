<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>compiment-cascade</title>
	<style>
	@charset "UTF-8";

	.compliment{
		position: fixed;
		font-size: 20px;
		opacity: 0;

		display: flex;
		align-items: center;
		justify-content: center;
		overflow: visible;
		white-space: nowrap;

		transition: font-size 10s, opacity 10s;

	    transform: translate(-50%, -50%);
	    left: 50%;
	    top: 50%;
	}

	.compliment.show {
		font-size: 200px;
		opacity: 1;
	}
	</style>
</head>
<body>
	<script>
		const complimentList = [
			<%
				List<String> compliments = (List<String>) request.getAttribute("compliments");
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

		// script.jsの内容をここに貼り付け
		var compliment = new Object();
		compliment.list = complimentList;

		compliment.set = function() {
			var span = document.createElement("span");
			span.className = "compliment";
			span.style.left = ( Math.random() * 100 ) + "%";
			span.style.top = ( Math.random() * 100 ) + "%";
			span.textContent = compliment.list[ Math.floor( Math.random()*compliment.list.length) ];

			span.addEventListener('transitionend', function(e) {
			    if (e.propertyName === 'opacity') {
			        this.remove();
			    }
			});

			document.body.appendChild( span );

			setTimeout(function(){
			  span.classList.add('show');
			}, 10);
		};

		window.addEventListener('DOMContentLoaded', (event) => {
			compliment.tmr = setInterval( compliment.set, 500 );
		});
	</script>
</body>
</html>