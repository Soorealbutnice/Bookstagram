<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   
<!-- --jquery cdn -->
<script type="text/javascript" src="${root}/js/board.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>

<!-- --부트스트랩 cdn -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
   integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
   crossorigin="anonymous">
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
   integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
   crossorigin="anonymous"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
   integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
   crossorigin="anonymous"></script>

<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">    
</head>
<style>
nav {
   display: block;
   color: #000;
   padding: 8px 8px;
   text-decoration: none;
}

nav.navbar-dark.bg-light {
   background-image:url(${root}/resources/img/bg2.jpg);
   position: fixed;
   width: 100%;
   z-index:4;
}

.form-group {
   margin-bottom: 0rem;
}

.col-2 {
   padding-right: 3px;
}

navbar-default {
   background-color: black;
}

.sidenav {
   height: 100%;
   width: 0;
   position: fixed;
   z-index: 5;
   top: 0;
   left: 0;
   background-color: #ffffff;
   overflow-x: hidden;
   transition: 0.5s;
   padding-top: 0px;
   border-right: 1px solid #a3a3c2;
   font-color: black;
}

.sidenav div.list{
   padding: 0px 50px 0px 0px;
   text-decoration: none;
   font-size: 15px;
   color: #3f3b3b;
   display: block;
   transition: 0.3s;
   text-align: top;
   margin-left: 0px;
}

.sidenav div {
   padding: 10px 8px 8px 32px;
   text-decoration: none;
   font-size: 15px;
   color: #a3a3c2;
   display: block;
}

.sidenav div.box {
   padding: 10px 8px 8px 32px;
   text-decoration: none;
   font-size: 15px;
   background-color: #f0f3f3;
   display: block;
   transition: 0.3s;
   text-align: center;
   margin-right: 3px;
}

.abc {
margin-left: 3px;
}

@media screen and (max-height: 450px) {
   .sidenav {
      padding-top: 15px;
   }
   .sidenav a {
      font-size: 18px;
   }
}

.sidenav .closebtn {
   position: absolute;
   top: 0;
   right: 25px;
   font-size: 36px;
   margin-left: 50px;
   color: #a3a3c2;
   text-decoration: none;
}

.tbutton {
   text-align: center;
   background: white;
   color: black;
   border: none;
   position: relative;
   height: 70px;
   font-size: 1.3em;
   padding: 0 3em;
   cursor: pointer;
   transition: 1500ms ease all;
   outline: none;
   left: 30px;
}

.tbutton:hover {
   background: #fff;
   color: #1AAB8A;
}

.tbutton:before, .tbutton:after {
   content: '';
   position: absolute;
   top: 0;
   right: 0;
   height: 2px;
   width: 0;
   background: #bfff00;
   transition: 400ms ease all;
}

.tbutton:after {
   right: inherit;
   top: inherit;
   left: 0;
   bottom: 0;
   border: none;
}

.tbutton:hover:before, .tbutton:hover:after {
   width: 110%;
   transition: 800ms ease all;
}

#toggle{
top : 70px;
}
</style>
<script>
$(document).ready(function() {
   $("#toggleBookSearch").click(function() {
         $("#listform").attr("method", "get").attr("action", "${root}/info/searchbook.dnb").submit();
      });
});

$(document).on('click', '#mainSearchBtn' , function(){
   var searchWord = $("#mainSearch").val();
   document.location.href= "${root}/main/searchMainCome.dnb?searchWord="+searchWord;
});

$(document).on('click', '#logout' , function(){
   document.location.href= "${root}/login/logout.dnb";
});

function mvMyPage(post_id){
      document.location.href= "${root}/mypage/mpreview.dnb?post_id="+post_id
}
</script>
<body>
<input type="hidden" name="word" value="">
   <nav class="navbar-dark bg-light">
   <div class="row">
      <div class="col-2 mt-2">
         <button class="navbar-toggler btn" id="topToggle" type="button" onclick="openNav()">
            <span style="color:white;" class="navbar-toggler-icon"></span>
         </button>
         <a href="${root}/main/firstComeMain.dnb"><img src="${root}/resources/img/mainlogo.png" style="width:43px"></a>
      </div>
      <div class="col-1">
      </div>
      <div class="col-6"></div>
      <div class="col-3">
         <div class="row" >
            <div class="col-7 mt-2">
               <input class="form-control mr-sm-2" type="search" placeholder="" aria-label="Search" id="mainSearch">
            </div>
            <div class="col-1 mt-2 mr-2">
               <button class="btn btn-outline-secondary" type="submit" id="mainSearchBtn">검색</button>
            </div>
            &nbsp;&nbsp;&nbsp;&nbsp;<br>
            <div class="col-3" >
               <a href="javascript:mvMyPage('${userInfo.id}');"><img class="rounded-circle" src="${root}/upload/profile/${userInfo.saveFolder}/${userInfo.save_proPicture}" width="50" height="50"></a>
            </div>
         </div>
      </div>
   </div>
   </nav>
 <div id="toggle" class="sidenav">
   <form id="listform" name="listform" method="get">
      <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
      <div class="box">
         <br><br> 
         <a href="${root}/mypage/mpreview.dnb?post_id=${userInfo.id}">
            <img src="${root}/upload/profile/${userInfo.saveFolder}/${userInfo.save_proPicture}" alt="picture" class="rounded-circle" width="130" height="130">
         </a>
         <br><br>
         <a href="${root}/mypage/mpreview.dnb?post_id=${userInfo.id}"><font style="color: #3f3b3b; font-size: 25px">${userInfo.nickname}</font></a>
         <br><br>
         <input type="button" class="btn btn-outline-info" value="글쓰기" style="width: 100px" onclick="location.href='${root}/post/write.dnb'">
         <br><br>
         <span style="display:inline-block;width:200px;margin-top:1px">
            <input class="form-control" type="search" placeholder="책 제목을 입력하세요." id="word" name="word">
         </span>
         <span>
            <button class="btn btn-outline-success " id="toggleBookSearch" style="display:none;">검색</button>
         </span>
       </div>
   </form>
   <br>
   <div class="list" align="center">
      <img class="abc" src="${root}/resources/img/seperator3.PNG" alt="picture" width="345" height="50">
      <br>
      <button class="tbutton" onclick="location.href='${root}/want/wantBookCome.dnb'">읽고 싶은 책</button>
      <br>
      <button class="tbutton" onclick="location.href='${root}/read/readBookCome.dnb'">읽은 책</button>
      <br>
      <button class="tbutton" onclick="location.href='${root}/chart/writereview.dnb'">내 독서 통계</button>
      <img class="abc" src="${root}/resources/img/seperator3.PNG" alt="picture" width="345" height="50">
      <button class="tbutton" id="logout">로그아웃</button>
   </div>
 </div>
</body>
<script>
function openNav() {
   document.getElementById("toggle").style.width = "350px";
   $("#topToggle").attr("onclick", "closeNav()");
}

function closeNav() {
   document.getElementById("toggle").style.width = "0";
   $("#topToggle").attr("onclick", "openNav()");
} 
</script>
</html>