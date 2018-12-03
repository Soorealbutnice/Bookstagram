<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.js"></script>
<script type="text/javascript" src="${root}/js/board.js"></script>
<script type="text/javascript">
control = "${root}/login";
initPath();
$(document).ready(function() {
   $("#frofileBtn").click(function() {
      if($("#nickname").val() == "") {
         alert("닉네임을 입력하세요");
         return;
      } else if($("#introduce").val() == "") {
         alert("한줄소개를 입력하세요");
         return;
      } else {
         $("form[name='writeForm']").attr("method", "POST").attr("action", "${root}/login/writeApi.dnb").submit();

      }
   });
});
</script>
<style>
html {
   background: url(${root}/resources/img/book.jpg) no-repeat center center
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
   background: transparent;
   height: 37px;
   color: #000;
   font-size: 16px;
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
   height: 37px;
   color: black;
   font-size: 16px;
   width: 40%;
}
div{
   color: black;
}
.loginbox input[type="file"] {

   color: #000;

}
</style>

<head>
<title>login form</title>
<body class="body">
<div class="cover">
   <div class="loginbox">
      <img src="${root}/resources/img/point.jpg" class="avatar">
      <h1>ProFile</h1>
      <h3>프로필을 설정해주세요</h3>
      <form id="writeForm" name="writeForm" method="post" action="" enctype="multipart/form-data" style="margin: 0px">
           <center>
           <img class="rounded-circle" id="pro" style="border-radius: 50%" src="${root}/resources/img/hyhy.png" width="75" height="75" align="absmiddle" float="ceter"><br><br>
            <br><input type="file" name="picture" id="picture" >
            </center>
         <input type="text" name="nickname" id="nickname" value=""  placeholder="닉네임">
         
         <input type="text" name="introduce" id="introduce" size="40" maxlength="40" placeholder="한줄소개">
         <input type="hidden" name = "key" value="${key}">;
         <input type="submit2" id="frofileBtn" value="계정만들기">
		</form>
	</div>
</div>
</body>
</head>
</html>