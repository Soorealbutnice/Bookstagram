<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../commons/top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
 h1 { 
	font-size: 250%; font-weight: bold; 
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2); 
	color: #666; border-bottom: 2px solid #ccc; 
	border-left: 10px solid #55555B; 
	text-height:200%; 
	padding: 3px 5px; 
	margin: 5px 0; 
	letter-spacing: 1px; 
	word-spacing: 3px; 
}
a {
	 text-decoration: none;
	 color:black;
	 outline:none;
} 
.follow {
   	 text-align: center;
}
.pro {
   height: 500;
}
.ri {
    text-align: right;
}
a.a {
  text-align: center;
  background:white;
  color:black;
  border:none;
  position:relative;
  height:80px;
  font-size:2.5em;
  padding:0 3em;
  cursor:pointer;
  transition:1500ms ease all;
  outline:none;
  left:30px;
  text-decoration: none;
}
a.a:hover {
  background:#fff;
  color:#1AAB8A;
}
a.a:before,a.a:after {
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #bfff00;
  transition:400ms ease all;
}
a.a:after {
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
a.a:hover:before,a.a:hover:after {
  width:100%;
  transition:800ms ease all;
}
a.btn {
   color: #28a745;
    background-color: transparent;
    background-image: none;
    border-color: #28a745;
}
a.btn:hover {
   background: #fff;
   color: #1AAB8A;
}
input {
   width: 100%;
   margin-bottom: 20px;
}
h3 {
	text-align:center;
	width: 350px;	
}
input[type="text"], input[type="password"] {
   border-bottom: 1px solid #fff;
   background: transparent;
   height: 37px;
   color: #000;
   font-size: 16px;
}
.email {
   border-bottom: 1px solid #fff;
   background: transparent;
   height: 37px;
   color: #000;
   font-size: 16px;
   width: 45%;
}
.row {
   float: center;
}
#updateform {
   float: center;
   
}
</style>
<script type="text/javascript">
var cnt = 1;
$(document).ready(function() {
   
   $("#updateBtn").click(function() {
      if($("#pass").val() == "") {
         alert("비밀번호 입력!");
         return;
      } else if($("#pass").val() != $("#passcheck").val()) {
         alert("비밀번호 확인!");
         return;
      } else {
    	  alert("변경이 완료되셨습니다")
         $("form[name='updateform']").attr("method", "POST").attr("action", "${root}/myup/update.dnb").submit();
      }
   });
   
   $("#deleteBtn").click(function() {
      if($("#pass").val() == "") {
         alert("비밀번호 입력!");
         return;
      } else if($("#pass").val() != $("#passcheck").val()) {
         alert("비밀번호 확인!");
         return;
      } else {
    	  alert("탈퇴가 완료되셨습니다")
         $("form[name='updateform']").attr("method", "POST").attr("action", "${root}/myup/delete.dnb").submit();
      }
   });
   
});
</script>
</head>
<body>
<!-----------내프로필표시--------->
<main role="main">
	<div class="container marketing pro">
    	<br><br><br>
        <img src="${root}/resources/img/hr.png" width="100%" height="50" style="float:center">
        <br>
        <h1>회원정보 수정</h1>
        <div class="container marketing pro" id="follow_id" data-follow_id="${userInfo.id}">
        	<center>
        	<div class="row" style=" margin-left: 40%">
         		<div class="col-lg-4 follow">
          			<br><br>
            			<img class="rounded-circle" src="${root}/upload/profile/${userInfo.saveFolder}/${userInfo.save_proPicture}" width="150" height="150">
          		</div><!-- /.col-lg-3 -->
          		<div class="col-lg-6">
            	<br><br><br><br>
         		</div><!-- /.col-lg-3 -->
         		<hr>
       		</div>
        	<h3>${userInfo.nickname}님</h3>
       		</center>
     	</div> 
        <form id="updateform" name="updateform" method="post" action="" style="width: 600px; margin-left: 22%" enctype="multipart/form-data">
     	<input type="hidden" id="id" name="id" value="${userInfo.id}">
        <br><br>
        <center>
        <br><input type="file" name="picture" id="picture" ><br>
        </center>
		         닉네임 :<input type="text" name="nickname" id="nickname" value="${userInfo.nickname}"><br>  
		         한줄소개 :<input type="text" name="introduce" id="introduce" size="40" maxlength="40" value="${userInfo.introduce}"><br>
		         	<input type="hidden" name = "key" value="${key}">
		         이름 :<input type="text" name="name" id="name" value="${userInfo.name}" maxlength="5"><br>
		         비밀번호 : <input type="password" name="pass" id="pass" size="12" maxlength="12" ><br>
		         비밀번호 확인 : <input type="password" name="passcheck" id="passcheck" size="12" maxlength="12" ><br>
     	<div>
         	  이메일 : <br><input type="text" class="email" name="email1" value="${userInfo.email1}" >@
         	 <input type="text" class="email" name="email2" value="${userInfo.email2}" >
        </div>
        <div>
            <p><a class="btn btn-secondary" href="#" role="button" style="float: right;" id="deleteBtn">탈퇴</a></p>
            <p><a class="btn btn-secondary" href="#" role="button" style="float: right;" id="updateBtn">수정</a></p>
        </div>
        </form>
     </div> 
     <br><br>
     <img src="${root}/resources/img/hr.png" width="100%" height="50" style="float:center">
     <!-- FOOTER -->
     <footer class="container">
       <p class="float-right"><a href="#" style="color: black">TOP</a></p>
       <p>© 2017-2018 Company, Inc. · <a href="#">Privacy</a> · <a href="#">Terms</a></p>
     </footer>
</main>
</body>
</html>