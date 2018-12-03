<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.js"></script>
<script type="text/javascript">
var cnt = 1;
$(document).ready(function() {
	
	$("#registerBtn").click(function() {
		if(cnt != 0) {	
			alert("아이디 중복 확인!");
			return;
		} else if($("#name").val() == "") {
			alert("이름 입력!");
			return;
		} else if($("#pass").val() == "") {
			alert("비밀번호 입력!");
			return;
		} else if($("#pass").val() != $("#passcheck").val()) {
			alert("비밀번호 확인!");
			return;
		} else {
			$("form[name='joinform']").attr("method", "POST").attr("action", "${root}/login/register.dnb").submit();
		}
	});
	
	$(document).keydown(function(key) {
		if (key.keyCode == 13) {
			if(cnt != 0) {	
				alert("아이디 중복 확인!");
				return;
			} else if($("#name").val() == "") {
				alert("이름 입력!");
				return;
			} else if($("#pass").val() == "") {
				alert("비밀번호 입력!");
				return;
			} else if($("#pass").val() != $("#passcheck").val()) {
				alert("비밀번호 확인!");
				return;
			} else {
				$("form[name='joinform']").attr("method", "POST").attr("action", "${root}/login/register.dnb").submit();
			}
		}
	});
	
	$("#id").keyup(function() {
		var id = $("#id").val();
		if(id.length < 5 || id.length > 16) {
			$("#idresult").css("color", "black");
			$("#idresult").text("아이디는 5자이상 16자이하입니다.");
		} else {
			$.ajax({
				type : "GET",
				url : "${root}/login/idcheck.dnb",
				dataType : "json",
				data : {"id" : id},
				success : function(data) {
					cnt = parseInt(data.idcount);
					if(cnt == 0) {
						$("#idresult").css("color", "blue");
						$("#idresult").text(id + "는 사용가능합니다.");
					} else {
						$("#idresult").css("color", "red");
						$("#idresult").text(id + "는 사용중입니다.");
					}
				},
				error : function(e) {
					
				}
			});
		}
	});
	
});

var view;
var id;

function idcheck() {
	view = document.getElementById("idresult");
	
	id = document.getElementById("id").value;
	if(id.length < 5 || id.length > 16) {
		view.innerHTML = "아이디는 5자이상 16자이하입니다.";
		return;
	}
	var params = "act=idsearch&id=" + id;
	sendRequest("${root}/user", params, idresult, "GET");
}

function idresult() {
	if(httpRequest.readyState == 4) {//처리완료
		if(httpRequest.status == 200) {
			cnt = httpRequest.responseText;
			if(cnt == 0) {
				view.innerHTML = '<font color="blue"><b>' + id + '</b>는 사용 가능합니다.</font>';
			} else {
				view.innerHTML = '<font color="red"><b>' + id + '</b>는 사용중입니다.</font>';
			}
		} else {
			alert("처리중 문제발생");
		}
	}
}
</script>
<style>
html {
	background: url(${root}/resources/img/backback.jpg) no-repeat center center
		fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
.loginbox {
	width: 380px;
	height: 600px;
	background: white;
	background-color: rgb(255, 255, 255);   
	color: #fff;
	top: 50%;
	left: 50%;
	position: absolute;
	transform: translate(-50%, -50%);
	box-sizing: border-box;
	padding: 70px 30px;
}
.avatar {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	position: absolute;
	top: 13px;
	left: calc(62% - 62px);
}
h1 {
	margin: 0;
	padding: 0 0 20px;
	text-align: center;
	font-size: 30px;
	color: black;
}
h3 {
	margin: 0;
	padding: 0 0 20px;
	color: darkgray;
	font-size: 15px;
	text-align: center;
}
.loginbox p {
	margin: -9;
	padding: -9;
	font-weight: bold;
}
.loginbox input {
	width: 100%;
	margin-bottom: 20px;
}
.loginbox input[type="text"], input[type="password"] {
	border-bottom: 1px solid #fff;
	height: 37px;
	background-color: rgba(255, 255, 255, 0.85);   
	color: #000;
	font-size: 16px;
	border-radius: 5px;
	height: 37px;
	
}
.loginbox input[type="email"]{
	border-bottom: 1px solid #fff;
	height: 37px;
	background-color: rgba(255, 255, 255, 0.85);   
	color: #000;
	font-size: 16px;
	border-radius: 5px;
	height: 37px;
	width : 50%;
}
.loginbox input[type="button"] {
	border: none;
	outline: none;
	height: 40px;
	background: #fb2525;
	color: #fff;
	font-size: 18px;
	border-radius: 20px;
}
.loginbox input[type="button"]:hover {
	cursor: pointer;
	background: gray;
	color: #000;
}
.loginbox input[type="submit2"] {
	margin:-41px;
	width: 380px;
	height: 150px;
	border: none;
	outline: none;
	height: 40px;
	background: darkgray;
	color: black;
	font-size: 18px;
	font-weight: bold;
	text-align: center;
	position: absolute;
	top: 100%;
	left: calc(27% - 62px);
	
}
.loginbox input[type="submit2"]:hover {
	cursor: pointer;
	background: gray;
	color: #000;
}
.email{
	border-bottom: 1px solid #fff;
	height: 37px;
	background-color: rgba(255, 255, 255, 0.85);   
	color: #000;
	font-size: 16px;
	border-radius: 5px;
	height: 37px;
	width : 40%;
}
div{
	color: black;
}
</style>
<head>
<title>Register</title>
</head>
<body class="body">
	<div class="loginbox">
		<img src="${root}/resources/img/point.jpg" class="avatar">
		<h1>JOIN</h1>
		<h3>회원가입에 실패하셨습니다</h3>
		<form name ="joinform" method="post" action="">
			<input type="text" name="name" id="name" value="" placeholder="Name" maxlength="5">
			<input type="text" name="id" id="id" value=""  placeholder="ID"><br><span id="idresult"></span>
			<input type="password" name="pass" id="pass" size="12" maxlength="12" placeholder="Pass Word">
			<input type="password" name="passcheck" id="passcheck" size="12" maxlength="12" placeholder="Pass Check">
			<div>
				인증 받을 이메일을 입력하세요<br><br>
				<input type="email" class="email" name="email1" value="" placeholder="Email">@
				<select name="email2" class="email">
			            <option value="naver.com">naver.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="google.com">google.com</option>
						<option value="nate.com">nate.com</option>
						<option value="icloud.com">icloud.com</option>
						<option value="daum.net">daum.net</option>
						<option value="outlook.com">outlook.com</option>
				</select>
			</div>
			<input type="submit2" id="registerBtn" value="계정만들기">
		</form>
	</div>
</body>
</html>