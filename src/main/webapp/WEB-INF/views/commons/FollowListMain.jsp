<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../commons/top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- font -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DND Main</title>
</head>
<style>
body{
   background-image:url(${root}/resources/img/bg2.jpg);
   background-size:cover;
   min-height:100vh;
}

A:link {text-decoration:none; color:#646464;}
A:visited {text-decoration:none; color:#646464;}
A:active {text-decoration:none; color:#646464;}
A:hover {text-decoration:none; color:#646464;}

#writerPhoto{
   width:45px;
   height:45px;
   margin-left:10px;
   margin-top:7px;
   margin-right:0px;
}

#writerId{
   margin: n;
   padding-left:5px;
   padding-right:0px;
   padding-top: 18px;
   color: gray; 
   font-size:2px;
  font-weight: 100;
}

.followIcon{
   margin-top: 16px;
   margin-right: 7px;
   right: 18px;
   margin-bottom: 0px;
   color:blue;
   font-size:1px;
   padding-right: 0px;
   padding-top: 0px;
   margin-right: 0px;
   width:25px;
   height:25px;
   border-right:10px;
}

.cancelIcon{
   margin-top: 16px;
   margin-right: 7px;
   right: 18px;
   margin-bottom: 0px;
   color:blue;
   font-size:1px;
   padding-right: 0px;
   padding-top: 0px;
   margin-right: 0px;
   width:25px;
   height:25px;
   border-right-width:10px;
}

.likeIcon{
   margin-right: 12px;
   margin-left: 3px;
   margin-bottom: 0px;
   color:blue;
   font-size:1px;
   padding-left:20px;
   padding-right: 0px;
   padding-top: 0px;
   width:25px;
   height:25px;
}

.cancelLikeIcon{
   width:50px;
   padding-top:0px;
   padding-right:1‒;
   padding-right:12px;
   padding-left: 8px;
}

.card{
   width:276px;
}

p{
   font-family: 'Nanum Myeongjo', serif;
   font-size : 1.4rem;
}

.text-muted{
font-size : 1.0rem;
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
});

$(document).on('click', '.followBtn' , function(){
     var post_id = $(this).data("post_id");
     $(this).children().attr("src", "${root}/resources/img/cancelIcon.png");
     $(this).children().attr("class", "cancelIcon");
     $(this).attr("class", "cancelBtn "+post_id);
     $(this).attr("href", "javascript:follow('"+post_id+"');");
     $(".followBtn."+post_id).children().attr("src", "${root}/resources/img/cancelIcon.png");
     $(".followBtn."+post_id).children().attr("class", "cancelIcon");
     $(".followBtn."+post_id).attr("class", "cancelBtn "+post_id);
     $(".followBtn."+post_id).attr("href", "javascript:follow('"+post_id+"');");
     
});

$(document).on('click', '.cancelBtn' , function(){
     var post_id = $(this).data("post_id");
     $(this).children().attr("src", "${root}/resources/img/addicon.png");
     $(this).children().attr("class", "followIcon");
     $(this).attr("class", "followBtn " +post_id);
     $(this).attr("href", "javascript:cancelFollow('"+post_id+"');");
     
     $(".cancelBtn."+post_id).children().attr("src", "${root}/resources/img/addicon.png");
     $(".cancelBtn."+post_id).children().attr("class", "followIcon");
     $(".cancelBtn."+post_id).attr("class", "followBtn "+post_id);
     $(".cancelBtn."+post_id).attr("href", "javascript:cancelFollow('"+post_id+"');");
});

$(document).on('click', '.likeBtn' , function(){
     var post_no = $(this).data("post_no");
     $(this).children().attr("src", "${root}/resources/img/fullheart.png");
     $(this).children().attr("class", "cancelLikeIcon");
     $(this).attr("class", "cancelLikeBtn");
     $(this).attr("href", "javascript:clickLike('"+post_no+"');");
     var likecount = $(this).parent().prev().data("likecount");
     likecount = Number(likecount) +1;
     $(this).parent().prev().children().text('좋아요 '+likecount+'개');
     $(this).parent().prev().data("likecount", likecount);
});

$(document).on('click', '.cancelLikeBtn' , function(){
   var post_no = $(this).data("post_no");
     $(this).children().attr("src", "${root}/resources/img/blackheart.png");
     $(this).children().attr("class", "likeIcon");
     $(this).attr("class", "likeBtn");
     $(this).attr("href", "javascript:cancelLike('"+post_no+"');");
     var likecount = $(this).parent().prev().data("likecount");
     likecount = Number(likecount)-1;
     $(this).parent().prev().children().text('좋아요 '+likecount+'개');
     $(this).parent().prev().data("likecount", likecount);
});

$(document).on('click', '.card-title', function(){
   var post_no =$(this).data("post_no");
   var post_id =$(this).data("post_id");
   window.location= "${root}/post/view.dnb?post_no="+post_no+"&post_id="+post_id;
});


function getList() {
    var listLength = $(".card").length;
     if(listLength == null){
           listLength = 0;
     }
     var parameter = {"listLength" : listLength};
     $.ajax({
          url : '${root}/main/followList.dnb',
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
   var followCheck = '${followCheck}';
   var pinList = '${pinList}';
   var plist = post.postList;
   var output = "";
   for(var i=0;i<plist.length;i++){
   if (plist[i].save_postPicture != null || plist[i].save_postPicture.trim() != "") {  
         output +=    '<figure style="display: inline-block;">';
      output +=     '<div class="card" id="imgCard" data-post_no="'+plist[i].post_no+'">';
      output +=        '<div class="card-head" style="height:60px;">';
      output +=           '<span class="float-left">';
      output +=             '<a href="#"><img src="${root}/upload/profile/'+plist[i].mSaveFolder+'/'+plist[i].save_proPicture+'" id="writerPhoto" data-post_id="'+plist[i].post_id+'" onclick="javascript:mvMyPage(\''+plist[i].post_id+'\');"></a>';
      output +=           '</span>';
      output +=           '<span class="float-left">';
      output +=              '<button type="button" class="btn btn-link" id="writerId" data-post_id="'+plist[i].post_id+'" onclick="javascript:mvMyPage(\''+plist[i].post_id+'\');"><h5><b>&nbsp;&nbsp;'+plist[i].nickname+'</b></h5></button>';
      output +=           '</span>';
      output +=          '<span class="float-right">';
      if(followCheck.indexOf(plist[i].post_id) == -1){
       output +=             '<a href="javascript:follow(\''+plist[i].post_id+'\');" class="followBtn '+plist[i].post_id+'" data-post_id="'+plist[i].post_id+'"><img src="${root}/resources/img/addicon.png" class="followIcon"></a>';
      } else{
       output +=             '<a href="javascript:cancelFollow(\''+plist[i].post_id+'\');" class="cancelBtn '+plist[i].post_id+'" data-post_id="'+plist[i].post_id+'"><img src="${root}/resources/img/cancelIcon.png" class="cancelIcon"></a>';
      }
      output +=            '</span>';
      output +=        '</div>';
      output +=       '<div>';
      output +=            '<a href="#"><img class="card-img-top card-title" data-post_id="'+plist[i].post_id+'" data-post_no="'+plist[i].post_no+'" src="${root}/upload/album/'+plist[i].pSaveFolder+'/'+plist[i].save_postPicture+'" id="mainImg"></a>';
      output +=          '<div class="card-body">';
      output +=             '<a href="#"><p class="card-text card-title" data-post_id="'+plist[i].post_id+'" data-post_no="'+plist[i].post_no+'">'+plist[i].simpleReview+'</p></a>';
      output +=              '<footer class="blockquote-footer">';
      output +=                 '<small class="text-muted">'+plist[i].book_name+'</small>';
      output +=               '</footer>';
      output +=         '</div>';
      output +=      '</div>';
      output +=       '<div class="card-footer" style="height:50px;width:100%;padding-right: 0px;">';
      output +=          '<span id="likeCount" class="float-left" style="margin-bottom:2px;" data-likecount="'+plist[i].like_count+'">';
      output +=            '<strong>좋아요 '+plist[i].like_count+'개</strong>';
      output +=         '</span>';
      output +=         '<span class="float-right">';
      if(pinList.indexOf(plist[i].post_no) == -1){
        output +=            '<a href="javascript:clickLike(\''+plist[i].post_no+'\');" class="likeBtn" data-post_no="'+plist[i].post_no+'"><img src="${root}/resources/img/blackheart.png" class="likeIcon" style="width:50px;"></a>';
      } else{
        output +=            '<a href="javascript:cancelLike(\''+plist[i].post_no+'\');" class="cancelLikeBtn" data-post_no="'+plist[i].post_no+'"><img src="${root}/resources/img/fullheart.png" class="cancelLikeIcon" style="width:50px;"></a>'; 
      }
      output +=          '</span>';
      output +=        '</div>';
      output +=     '</div>';
      output +=   '</figure>';
   } else{
      output +=   '<div class="card" id="textCard"  data-post_no="'+plist[i].post_no+'">';
      output +=      '<div class="card-head" style="height:60px;">';
      output +=           '<span class="float-left">';
      output +=             '<a href="javascript:mvMyPage(\''+plist[i].post_id+'\');"><img src="${root}/upload/profile/'+plist[i].mSaveFolder+'/'+plist[i].save_proPicture+' id="writerPhoto" data-post_id="'+plist[i].post_id+'"></a>';
      output +=          '</span>';
      output +=           '<span class="float-left">';
      output +=              '<button type="button" class="btn btn-link" id="writerId" data-post_id="'+plist[i].post_id+'" onclick="javascript:mvMyPage(\''+plist[i].post_id+'\');">'+plist[i].nickname+'</button>';
      output +=           '</span>';
      output +=          '<span class="float-right">';
      if(followCheck.indexOf(plist[i].post_id) == -1){
        output +=             '<a href="javascript:follow(\''+plist[i].post_id+'\');" class="followBtn '+plist[i].post_id+'" data-post_id="'+plist[i].post_id+'"><img src="${root}/resources/img/addicon.png" class="followIcon"></a>';
      } else{
         output +=             '<a href="javascript:cancelFollow(\''+plist[i].post_id+'\');" class="cancelBtn '+plist[i].post_id+'" data-post_id="'+plist[i].post_id+'"><img src="${root}/resources/img/cancelIcon.png" class="cancelIcon"></a>';
      }
      output +=            '</span>';
      output +=        '</div>';
      output +=     '<div>';
      output +=       '<blockquote class="blockquote mb-0 card-body">';
      output +=           '<a href="#"><p class="card-title" data-post_id="'+plist[i].post_id+'" data-post_no="'+plist[i].post_no+'">'+plist[i].simpleReview+'</p></a>';
      output +=          '<footer class="blockquote-footer">';
      output +=               '<small class="text-muted">'+plist[i].book_name+'</small>';
      output +=           '</footer>';
      output +=       '</blockquote>';
      output +=       '<br>';
      output +=       '<hr style="margin:0px">';
      output +=     '</div>';
      output +=       '<div class="card-footer" style="height:50px;width:100%;padding-right: 0px;">';
      output +=          '<span id="likeCount" class="float-left" style="margin-bottom:2px;" data-likecount="'+plist[i].like_count+'">';
      output +=            '<strong>좋아요 '+plist[i].like_count+'개</strong>';
      output +=         '</span>';
      output +=         '<span class="float-right">';
      if(pinList.indexOf(plist[i].post_no) == -1){
      output +=            '<a href="javascript:clickLike(\''+plist[i].post_no+'\');" class="likeBtn" data-post_no="'+plist[i].post_no+'"><img src="${root}/resources/img/blackheart.png" class="likeIcon" style="width:50px;"></a>';
      } else{
      output +=            '<a href="javascript:cancelLike(\''+plist[i].post_no+'\');" class="cancelLikeBtn" data-post_no="'+plist[i].post_no+'"><img src="${root}/resources/img/fullheart.png" class="cancelLikeIcon" style="width:50px;"></a>'; 
      }
      output +=          '</span>';
      output +=        '</div>';
      output +=     '</div>';
     
   }
}
   $("#appendTarget").append(output);
}

function mvMyPage(post_id){
   document.location.href= "${root}/mypage/mpreview.dnb?post_id="+post_id
}



function follow(posting_id){
    var parameter = {"followed_id" : posting_id};
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

function cancelFollow(posting_id){
    var parameter = {"followed_id" : posting_id};
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


function clickLike(post_no){
    var parameter = {"post_no" : post_no};
    $.ajax({
      url : '${root}/post/likePost.dnb',
      type : 'GET',
      contentType : 'application/json;charset=UTF-8',
      data : parameter,
      dataType : 'json',
      success : function() {
      }
   }); 
}

function cancelLike(post_no){
    var parameter = {"post_no" : post_no};
    var addIcon = $(this);
    $.ajax({
      url : '${root}/post/cancelLike.dnb',
      type : 'GET',
      contentType : 'application/json;charset=UTF-8',
      data : parameter,
      dataType : 'json',
      success : function(data) {
      }
   }); 
}
</script>
<body>
<br>
<br>
<br>
<br>
<br>
<main role="main">
   <div class="container">
      <div class="row">
<!-- ------------------------------------------------여기 아래에 각자 뷰 만들기--------------------------------------------------------- -->
<!--------------------------------------------------------드롭다운 버튼------------------------------------------------------------ -->
         <div class="dropdown">
           <button class="btn btn-secondary dropdown-toggle btn-sm" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              글 정렬
           </button>
           <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
             <a class="dropdown-item" href="${root}/main/firstComeMain.dnb">모든글</a>
             <a class="dropdown-item" href="${root}/main/followMainCome.dnb">팔로잉</a>
           </div>
         </div>
         <br><br>
<!----------------------------------------------------------본문 카드------------------------------------------------------------->
          <div class="card-columns" id="appendTarget">

          </div>
<!-------------------------------------------------------여기 위에 각자 뷰 만들기------------------------------------------------------->   
      </div><!-- /row -->
   </div> <!-- /container -->
</main>
</body>
</html>