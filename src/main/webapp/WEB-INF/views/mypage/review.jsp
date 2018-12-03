<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../commons/top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
 a{
 text-decoration: none;
 color:black;
 outline:none;
 } 
  .follow{
    text-align: center;
  }
  .pro{
    height: 500;

  }
 .ri{
    text-align: right;
  }
  
a.a{
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
a.a:hover{
  background:#fff;
  color:#1AAB8A;
}
a.a:before,a.a:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #bfff00;
  transition:400ms ease all;
}
a.a:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
a.a:hover:before,a.a:hover:after{
  width:100%;
  transition:800ms ease all;
}
a.btn{
   color: #28a745;
    background-color: transparent;
    background-image: none;
    border-color: #28a745;
}
a.btn:hover {
   background: #fff;
   color: #1AAB8A;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
   getList();
   
  $(document).scroll(function() {
    var maxHeight = $(document).height();
    var currentScroll = $(window).scrollTop() + $(window).height();
    if (maxHeight <= currentScroll) {
         getList();
    }
  });
  
  $("#updateBtn").click(function() {   
      document.location.href="${root}/myup/update.dnb"
  }); 
  
});

function getList() {
    var post_no = $(".row").last().data("post_no");
    if(post_no == null){
        post_no = 0;
    } 
    var post_id = $("#post_id").data("post_id");
    var parameter = {"post_no" : post_no, "post_id" : post_id};
    $.ajax({
      url : '${root}/mypage/review.dnb',
      type : 'GET',
      contentType : 'application/json;charset=UTF-8',
      data : parameter,
      dataType : 'json',
      success : function(data) {
         makeList(data);
      }
   });
}


function makeList(post) {
   var plist = post.postList;
   var output = "";
   if(plist.length != 0){
      for(var i=0;i<plist.length;i++) {
         output +=      '<br><hr><br>';
         if(plist[i].bookImg != null) {
         output +=   '<div class="row" data-post_no="'+plist[i].post_no+'">';
         output +=        '<div class="col-md-3 offset-md-1">'
         output +=          '<img src="'+plist[i].bookImg+'" style="width: 200px; height: 300px;">';
         output +=        '</div>';
         output +=        '<div class="col-md-8">';
         output +=             '<h2 class="featurette-heading"><a href="javascript:openPost('+plist[i].post_no+');" style="color: black">'+plist[i].book_name+'</a></h2>';
         output +=          '<p class="lead">'+plist[i].simplereview+'</p>';
         output +=         '<label style="align:right;">'+plist[i].write_date+'</label>';
         output +=        '</div>';
         output +=    '</div>';
         } else if(plist[i].save_postPicture != null) {
            output +=   '<div class="row" data-post_no="'+plist[i].post_no+'">';
            output +=        '<div class="col-md-3 offset-md-1">'
            output +=          '<img src="${root}/upload/album/'+plist[i].psaveFolder+'/'+plist[i].save_postPicture+'" style="width: 200px; height: 300px;">';
            output +=        '</div>';
            output +=        '<div class="col-md-8">';
            output +=             '<h2 class="featurette-heading"><a href="javascript:openPost('+plist[i].post_no+');" style="color: black">'+plist[i].book_name+'</a></h2>';
            output +=          '<p class="lead">'+plist[i].simplereview+'</p>';
            output +=         '<label style="align:right;">'+plist[i].write_date+'</label>';
            output +=        '</div>';
            output +=    '</div>';
         } else{
            output +=      '<div class="row" data-post_no="'+plist[i].post_no+'">';
            output +=       '<div class="col-md-11 offset-md-1">';
            output +=             '<h2 class="featurette-heading"><a href="javascript:openPost('+plist[i].post_no+');" style="color: black">'+plist[i].title+'</a></h2>';
            output +=             '<p class="lead">'+plist[i].simplereview+'</p>';
            output +=            '<label>'+plist[i].write_date+'</label>';
            output +=         '</div>';
            output +=     '</div>';
         }   
      }
   } else if(plist.length == 0 ){
      return;
   }
   $("#container").append(output);
}
   
function openPost(post_no){
   var post_id = $("#post_id").data("post_id");
   document.location.href= "${root}/post/view.dnb?post_no="+post_no+"&post_id="+post_id;
}

function follow(followed_id){
    $("#followBtn").text('구독중');
    $("#followBtn").attr("onclick", "javascript:cancelFollow('"+followed_id+"');");
    $("#followBtn").attr("class", "btn btn-secondary");
    $("#followBtn").attr("id", "cancelFollowBtn");
    
	 var parameter = {"followed_id" : followed_id};
	 $.ajax({
		url : '${root}/follow/follow.dnb',
		type : 'GET',
		contentType : 'application/json;charset=UTF-8',
		data : parameter,
		dataType : 'json',
		success : function() {
		}
	}); 
}

function cancelFollow(followed_id){
   $("#cancelFollowBtn").text('구독하기');
   $("#cancelFollowBtn").attr("onclick", "javascript:follow('"+followed_id+"');");
   $("#cancelFollowBtn").attr("class", "btn btn-outline-secondary");
   $("#cancelFollowBtn").attr("id", "followBtn");
   
   var parameter = {"followed_id" : followed_id};
	 $.ajax({
		url : '${root}/follow/cancelFollow.dnb',
		type : 'GET',
		contentType : 'application/json;charset=UTF-8',
		data : parameter,
		dataType : 'json',
		success : function() {
		}
	}); 
}

</script>
 </head>
 <body>
<!-----------내프로필표시------->
     <main role="main" >
      <div class="container marketing pro" id="post_id" data-post_id="${member.id}">
       <div class="row" >
         <div class="col-lg-4 follow">
	        <br><br><br><br><br><br>
	        <img class="rounded-circle" src="${root}/upload/profile/${member.saveFolder}/${member.save_proPicture}" width="240" height="240">
         </div><!-- /.col-lg-3 -->
         <div class="col-lg-6">
            <br><br><br><br><br><br><br>
            <h1><a href="#" style="color:black">${member.nickname}</a></h1>
            <p>후기  ${postCount} | 팔로워 ${meFollowerCount} | 구독자 ${followCount}</p>
            <br>
            <h3>${member.introduce}</h3>
            <br>
            <c:choose>
	            <c:when test="${member.id == userInfo.id}">
	                <p><a class="btn btn-secondary" id="updateBtn" role="button" style="float: right;">정보수정»</a></p>
	            </c:when>
	            <c:otherwise>
		            <c:if test="${followStatus.follow_no == null}">
		                	<button id="followBtn" onclick="javascript:follow('${member.id}');"  class="btn btn-outline-secondary"  style="height:40px;float: right;">구독하기</button> 
		            </c:if>
		            <c:if test="${followStatus.follow_no != null}">
		                	<button id="cancelFollowBtn" onclick="javascript:cancelFollow('${member.id}');"  class="btn btn-secondary"  style="height:40px;float: right;">구독중</button> 
		            </c:if>
	            </c:otherwise>
            </c:choose>
         </div><!-- /.col-lg-3 -->
         <hr>
       </div>
     </div>
     <br><br>
     <img src="${root}/resources/img/hr.png" width="100%" height="50" style="float:center">
     <!------------------------------------------------ 메뉴 버튼 -->
     <div class="container marketing"  height="50px">
        <div class="row justify-content-center">
          <a href="${root}/mypage/mpreview.dnb?post_id=${member.id}" class="a" style="padding-left: 0px; padding-right: 60px">포스트</a>  
          <a href="${root}/mypage/mpfollow.dnb?post_id=${member.id}" class="a" style="padding-left: 60px; padding-right: 60px" >구독자</a>
          <c:if test="${userInfo.id == member.id}">
	          <a href="${root}/mypage/mpMySupporter.dnb" class="a" style="padding-left: 60px; padding-right: 60px">후원 받은 내역</a>
	          <a href="${root}/mypage/mpISupporter.dnb" class="a" style="padding-left: 60px; padding-right: 0px">나의 후원 내역</a>
          </c:if>
        </div>
      </div>
      <div class="container marketing" id="container">
        <!----------------------- 리뷰 화면 ------------>

        <!----------------------- 리뷰 화면------------>
        <hr class="featurette-divider">
      </div><!-- /.container -->
      <!-- FOOTER -->
      <footer class="container">
        <p class="float-right"><a href="#" style="color: black">TOP</a></p>
        <p>© 2017-2018 Company, Inc. · <a href="#">Privacy</a> · <a href="#">Terms</a></p>
      </footer>
    </main>
</body>
</html>