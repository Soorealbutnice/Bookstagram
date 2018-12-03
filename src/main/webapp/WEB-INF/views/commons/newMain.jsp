<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<title>DNB Main</title>
<style>
body{
   background-image:url(${root}/resources/img/bg2.jpg);
   background-size:cover;
   min-height:100vh;
}
#mainContainer{
padding-right : 250px;
padding-left : 250px;
}
A:link {text-decoration:none; color:#646464;}
A:visited {text-decoration:none; color:#646464;}
A:active {text-decoration:none; color:#646464;}
A:hover {text-decoration:none; color:#646464;}
.card-head{
	height:60px;
	background-color:white;
	border-radius: 5px 5px 0px 0px;
}
.card-head.text{
	height:60px;
	background-color:white;
	border-radius: 5px 5px 0px 0px;
	border-bottom: 1px solid lightgray;
}
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
   color: #444444; 
   font-size:1px;
   font-weight: 100;
}

.followIcon{
   margin-top: 20px;
   margin-right: 10px;
   width:25px;
   height:25px;
}

.cancelIcon{
   margin-top: 20px;
   margin-right: 10px;
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
   width:23px;
   padding-top:2.5px;
}

.cancelLikeIcon{
   width:45px;
   padding-top:0px;
   padding-right:1‒;
   padding-right:12px;
   padding-left: 8px;
}

p{
   font-family: 'Nanum Myeongjo', serif;
   font-size : 1.4rem;
}
.card-footer{
	height:35px;
	padding-top : 4px;
}
.text-muted{
	font-size : 1.0rem;
}
.likeCount{

	font-size:0.8rem;
	color:darkgray;
}


#dropdown {
	padding-top: 80px;
}

figure {
	background-color : white;
	border-radius : 0 0 5px 5px;
}

figure img {
	width: 100%;
}

figure figcaption {
	padding-top: 11px;
	margin-bottom: 11px;
	padding-left:10px;
}
/* 
.grid {
	max-width: 1400px;
}
 */
.grid:after {
  content: '';
  display: block;
  clear: both;
}

.grid-item {
	width: 300px;
	height: auto;
 	float: left;
	padding-right: 10px;
	padding-left: 10px; 
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
   var listLength = $(".grid-item").length;
    if(listLength == null){
       listLength = 0;
    } 

    var parameter = {"listLength" : listLength};
    $.ajax({
      url : '${root}/main/mainAllList.dnb',
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
		output +='	<div class="grid-item" data-post_no="'+plist[i].post_no+'">';
		output +='		<div class="card-head">';
		output +='			<span class="float-left">';
		output +='		    	<a href="#"><img src="${root}/upload/profile/'+plist[i].mSaveFolder+'/'+plist[i].save_proPicture+'" id="writerPhoto"  data-post_id="'+plist[i].post_id+'" onclick="javascript:mvMyPage(\''+plist[i].post_id+'\');"></a>';
		output +='			</span>';
		output +='		    <span class="float-left">';
		output +='		   		<button type="button" class="btn btn-link" id="writerId" data-post_id="'+plist[i].post_id+'" onclick="javascript:mvMyPage(\''+plist[i].post_id+'\');"><h5><b>&nbsp;&nbsp;'+plist[i].nickname+'</b></h5></button>';
		output +='		 	</span>';
		output +='		 	<span class="float-right">';
	     	if(followCheck.indexOf(plist[i].post_id) == -1){
	          output +=             '<a href="javascript:follow(\''+plist[i].post_id+'\');" class="followBtn '+plist[i].post_id+'" data-post_id="'+plist[i].post_id+'"><img src="${root}/resources/img/addicon.png" class="followIcon"></a>';
	        } else{
	          output +=             '<a href="javascript:cancelFollow(\''+plist[i].post_id+'\');" class="cancelBtn '+plist[i].post_id+'" data-post_id="'+plist[i].post_id+'"><img src="${root}/resources/img/cancelIcon.png" class="cancelIcon"></a>';
	        }
		output +='		    </span>';
		output +='	 	</div>';
		output +='		<div>';
		output +='			<figure>';
		output +='				<a href="#"><img class="card-title" data-post_id="'+plist[i].post_id+'" data-post_no="'+plist[i].post_no+'" src="${root}/upload/album/'+plist[i].pSaveFolder+'/'+plist[i].save_postPicture+'" id="mainImg"></a>';
		output +='				<figcaption class="card-title" data-post_id="'+plist[i].post_id+'" data-post_no="'+plist[i].post_no+'">';
		output +='					<a href="#">'+plist[i].simpleReview+'</a>';
        output +='              	<footer class="blockquote-footer">';
        output +='                  	<small class="text-muted">'+plist[i].book_name+'</small>';
        output +='                  </footer>';
        output +='              </figcaption>';
		output +='				<div class="card-footer">';
		output +='	        		<span id="likeCount" class="likeCount" data-likecount="'+plist[i].like_count+'">';
		output +='			        	<strong>좋아요 '+plist[i].like_count+'개</strong>';
		output +='	        		</span>';
		output +='		        	<span class="float-right">';
	      	if(pinList.indexOf(plist[i].post_no) == -1){
	          output +='					<a href="javascript:clickLike(\''+plist[i].post_no+'\');" class="likeBtn" data-post_no="'+plist[i].post_no+'"><img src="${root}/resources/img/blackheart.png" class="likeIcon" style="width:50px;"></a>';
	        } else{
	          output +='					<a href="javascript:cancelLike(\''+plist[i].post_no+'\');" class="cancelLikeBtn" data-post_no="'+plist[i].post_no+'"><img src="${root}/resources/img/fullheart.png" class="cancelLikeIcon" style="width:50px;"></a>'; 
	        }
		output +='       			</span>';
		output +='				</div>';
		output +='			</figure>';
		output +='		</div>';
		output +='	</div>';   
	   } else{
		output +='	<div class="grid-item" data-post_no="'+plist[i].post_no+'">';
		output +='		<div class="card-head text">';
		output +='			<span class="float-left">';
		output +='		    	<a href="#"><img src="${root}/upload/profile/'+plist[i].mSaveFolder+'/'+plist[i].save_proPicture+'" id="writerPhoto"  data-post_id="'+plist[i].post_id+'" onclick="javascript:mvMyPage(\''+plist[i].post_id+'\');"></a>';
		output +='			</span>';
		output +='		    <span class="float-left">';
		output +='		   		<button type="button" class="btn btn-link" id="writerId" data-post_id="'+plist[i].post_id+'" onclick="javascript:mvMyPage(\''+plist[i].post_id+'\');"><h5><b>&nbsp;&nbsp;'+plist[i].nickname+'</b></h5></button>';
		output +='		 	</span>';
		output +='		 	<span class="float-right">';
	     	if(followCheck.indexOf(plist[i].post_id) == -1){
	          output +=             '<a href="javascript:follow(\''+plist[i].post_id+'\');" class="followBtn '+plist[i].post_id+'" data-post_id="'+plist[i].post_id+'"><img src="${root}/resources/img/addicon.png" class="followIcon"></a>';
	        } else{
	          output +=             '<a href="javascript:cancelFollow(\''+plist[i].post_id+'\');" class="cancelBtn '+plist[i].post_id+'" data-post_id="'+plist[i].post_id+'"><img src="${root}/resources/img/cancelIcon.png" class="cancelIcon"></a>';
	        }
		output +='		    </span>';
		output +='	 	</div>';
		output +='		<div>';
		output +='			<figure>';
		output +='				<figcaption class="card-title" data-post_id="'+plist[i].post_id+'" data-post_no="'+plist[i].post_no+'">';
		output +='					<a href="#">'+plist[i].simpleReview+'</a>';
        output +='              	<footer class="blockquote-footer">';
        output +='                  	<small class="text-muted">'+plist[i].book_name+'</small>';
        output +='                  </footer>';
        output +='              </figcaption>';
		output +='				<div class="card-footer">';
		output +='	        		<span id="likeCount" class="likeCount" data-likecount="'+plist[i].like_count+'">';
		output +='			        	<strong>좋아요 '+plist[i].like_count+'개</strong>';
		output +='	        		</span>';
		output +='		        	<span class="float-right">';
	      	if(pinList.indexOf(plist[i].post_no) == -1){
	          output +='					<a href="javascript:clickLike(\''+plist[i].post_no+'\');" class="likeBtn" data-post_no="'+plist[i].post_no+'"><img src="${root}/resources/img/blackheart.png" class="likeIcon" style="width:50px;"></a>';
	        } else{
	          output +='					<a href="javascript:cancelLike(\''+plist[i].post_no+'\');" class="cancelLikeBtn" data-post_no="'+plist[i].post_no+'"><img src="${root}/resources/img/fullheart.png" class="cancelLikeIcon" style="width:50px;"></a>'; 
	        }
		output +='       			</span>';
		output +='				</div>';
		output +='			</figure>';
		output +='		</div>';
		output +='	</div>';      
	   }
   }
   $("#appendTarget").append(output);

}


function layoutArrange(){
	alert('되니?');
   $('.grid').masonry({
		  itemSelector: '.grid-item',
		  columnWidth: 160,
		  gutter: 20
	});
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
</head>
<body>
	<div class="dropdown" id="dropdown">
		<button class="btn btn-secondary dropdown-toggle btn-sm" type="button"
			id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false">글 정렬</button>
		<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
			<a class="dropdown-item" href="${root}/main/firstComeMain.dnb">모든글</a>
			<a class="dropdown-item" href="${root}/main/followMainCome.dnb">팔로잉</a>
		</div>
	<div>
	<button class="btn btn-secondary" type="button" onclick="javascript:layoutArrange();">어떻게 되나 함 보자!!</button>
	</div>
	</div>
	<br><br><br><br><br>
<div id="mainContainer">
	<div id="appendTarget" class="grid">
	
	</div> <!-- class grid -->
</div>
</body>

</html>