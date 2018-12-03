<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<%
Cookie cookie[] = request.getCookies();
String id = "";
String ck = "";
if(cookie != null) {
	int len = cookie.length;
	for(int i=0;i<len;i++) {
		if("loginid".equals(cookie[i].getName())) {
			id = cookie[i].getValue();
			ck = " checked=\"checked\"";
			break;
		}
	}
}
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#loginBtn").click(function() {
		if($("#id").val() == "") {
			alert("아이디 입력!");
			return;
		} else if($("#pass").val() == "") {
			alert("비밀번호 입력!");
			return;
		} else {
			$("form[name='loginform']").attr("method", "POST").attr("action", "${root}/login/login.dnb").submit();
		}
	});
	
	$(document).keydown(function(key) {
		if (key.keyCode == 13) {
			if($("#id").val() == "") {
				alert("아이디 입력!");
			} else if($("#pass").val() == "") {
				alert("비밀번호 입력!");
				return;
			} else if($("#id").val() == "admin"){
				$("form[name='loginform']").attr("method", "POST").attr("action", "${root}/admin/login.dnb").submit();
			}else{
				$("form[name='loginform']").attr("method", "POST").attr("action", "${root}/login/login.dnb").submit();
			}
		}
	});
	
	$("#registerBtn").click(function() {
		$(location).attr("href", "${root}/login/register.dnb");
	});
	
});
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

.cover{
   position: absolute;
   height: 100%;
   width: 100%;
   background-color: rgba(0, 0, 0, 0.15);                                                                 
   z-index:1;
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
	left: calc(60% - 62px);
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
	color: black;
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
	border-radius: 4px;
	
}

.loginbox input[type="text"], input[type="password"] {
	border-bottom: 1px solid #fff;
	height: 37px;
	background-color: rgba(255, 255, 255, 0.85);   
	color: #000;
	font-size: 16px;
	border-radius: 5px;
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
	background: #cc0000;
	color: white;
}

.loginbox input[type="submit2"] {
	margin: -30px;
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
	border-radius : 0;
}

.loginbox input[type="submit2"]:hover {
	cursor: pointer;
	background: gray;
	color: #000;
}

.snsLogin {
	padding-top : 4px;
	height : 44px;
	width : 223px;
}
</style>
<head>
<title>login</title>
</head>
<body class="body">
<div class="cover">
	<div class="loginbox">
		<img src="${root}/resources/img/point.jpg" class="avatar">
		<h1>Login</h1>
		<h3>로그인에 실패하였습니다.</h3>
		<form name="loginform" method="post" action="">
			<input type="text" name="id" id="id" value="<%=id%>" placeholder="Enter ID">
			<input type="Password" name="pass" id="pass" placeholder="Enter Password">
			<input type="button" value="계속하기" id="loginBtn">
				<h3>또는</h3>
			<input type="submit2" id="registerBtn" value="계정만들기">

		<!-- 네이버 로그인 화면으로 이동 시키는 URL -->
		<div id="naver_id_login" id="naverBtn" style="text-align: center">
			<a href="${url}"> <img class="snsLogin" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" /></a>
		</div>
		<div id="google_id_login" id="googleBtn" style="text-align: center">
			<a href="${google_url}"><img class="snsLogin" src="${pageContext.request.contextPath}/resources/img/googleLogin.png"/></a>
		</div>
		</form>
	</div>
</div>
</body>
</head>
</html>