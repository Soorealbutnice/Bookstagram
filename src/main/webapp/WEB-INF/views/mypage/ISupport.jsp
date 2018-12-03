<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../commons/top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
a{
   text-color:black;
}
</style>
<script type="text/javascript">
initPath();

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
	 var isupport_no = $(".row").last().data("isupport_no");
	 if(isupport_no == null){
		 isupport_no = 0;
	 } 
	 var parameter = {"isupport_no" : isupport_no};
	 $.ajax({
		url : '${root}/mypage/isupport.dnb',
		type : 'GET',
		contentType : 'application/json;charset=UTF-8',
		data : parameter,
		dataType : 'json',
		success : function(data) {
			makeList(data);
		}
	});
}

function makeList(isupport) {
	var islist = isupport.isupportList;
	var output = "";
	for(var i=0;i<islist.length;i++){
		output +=  '<div class="row" data-isupport_no="'+islist[i].support_no+'">';
		output +=  ' <div class="col-lg-8">';
		output +=   '<h2><a href="javascript:mvMyPage(\''+islist[i].supported_id+'\');" style="color:black">'+islist[i].supported_id+'</a>님에게</h2>';
		output +=    '<h4><label>'+islist[i].pay+'원</label>후원하셨습니다.</h4><br>';
		output +=    ' <label>'+islist[i].support_date+'</label>';
		output +=  ' </div>';
		output +=   ' <div class="col-lg-4 ">';
		output +=     ' <img class="rounded-circle" src="${root}/upload/profile/'+islist[i].saveFolder+'/'+islist[i].save_proPicture+'" width="170" height="170">';
		output +=  '  </div>';
		output += ' </div>';
		output +=	'<br><hr><br>';
	}
	$("#container").append(output);
}

function mvMyPage(post_id){
	   document.location.href= "${root}/mypage/mpreview.dnb?post_id="+post_id
}
</script>
</head>
  <body>
  <!--------------------------------------------------내프로필표시-->
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
            <c:if test="${member.id == userInfo.id}">
                <p><a class="btn btn-secondary" id="updateBtn" role="button" style="float: right;">정보수정»</a></p>
            </c:if>
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
      <hr>
      <div class="container marketing" >
        <!-- 리뷰 화면 보여주는곳 -->
       <h2 class="ri">나의 후원 내역</h2>
	   <hr><br>
	   <div id="container">
<!-------후원 받은 내역 ------------>

<!-------후원 받은 내역 ----------->         
       </div>
      </div><!-- /.container -->
<!-- FOOTER -->
      <footer class="container">
        <p class="float-right"><a href="#" style="color: black">TOP</a></p>
        <p>© 2017-2018 Company, Inc. · <a href="#">Privacy</a> · <a href="#">Terms</a></p>
      </footer>
    </main>
</body>
</html>