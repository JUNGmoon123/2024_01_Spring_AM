<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="AjaxTestPage"></c:set>

<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>AjaxTestPage</title>
<style type="text/css">
.rs {
	border: 5px solid black;
	margin-top: 10px;
	padding: 20px;
	font-size: 3rem;
}
</style>
<!-- 제이쿼리 불러오기 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	function callByAjax() {
		var form = document.form1;
		var num1 = form.num1.value;
		var num2 = form.num2.value;
		// 		var action = './doPlus';
		var action = form.action;
		$.get(action, {
			num1 : num1,
			num2 : num2
		}, function(data) {
			// 			$('.rs').append(data);
			// 			$('.rs').empty().append(data);
			$('.rs').text(data);
		}, 'html');
	}
</script>
</head>
<body>
	<h1>AjaxTestPage</h1>
	<form name="form1" method="POST" action="./doPlus">
		<div>
			<input type="text" name="num1" placeholder="정수 입력" />
		</div>
		<div>
			<input type="text" name="num2" placeholder="정수 입력" />
		</div>
		<input type="submit" value="더하기v1" />
		<input onclick="callByAjax();" type="button" value="더하기v2" />
	</form>
	<h2>더한 결과</h2>
	<div class="rs"></div>
</body>
</html>