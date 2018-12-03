<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../commons/top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"></script>
<script src="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700"></script>
<script src="https://fonts.googleapis.com/css?family=Libre+Baskerville:400,700"></script>
<title>Insert title here</title>
</head>

<style>

/*Profile card 4*/
.abc{
	float:left;
}
.profile-card-4 .card-img-block{
    float:left;
    width:100%;
    height:150px;
    overflow:hidden;
}
.profile-card-4 .card-body{
    position:relative;
}
.profile-card-4 .profile {
    border-radius: 50%;
    position: absolute;
    top: -62px;
    left: 50%;
    width:100px;
    border: 3px solid rgba(255, 255, 255, 1);
    margin-left: -50px;
}
.profile-card-4 .card-img-block{
    position:relative;
}
.profile-card-4 .card-img-block > .info-box{
    position:absolute;
    background:rgba(217,11,225,0.6);
    width:100%;
    height:100%;
    color:#fff;
    padding:20px;
    text-align:center;
    font-size:14px;
   -webkit-transition: 1s ease;
    transition: 1s ease;
    opacity:0;
}
.profile-card-4 .card-img-block:hover > .info-box{
    opacity:1;
    -webkit-transition: all 1s ease;
    transition: all 1s ease;
}
.profile-card-4 h5{
    font-weight:600;
    color:#d90be1;
}
.profile-card-4 .card-text{
    font-weight:300;
    font-size:15px;
}
.profile-card-4 .icon-block{
    float:left;
    width:100%;
}
.profile-card-4 .icon-block a{
    text-decoration:none;
}
.profile-card-4 i {
  display: inline-block;
    font-size: 16px;
    color: #d90be1;
    text-align: center;
    border: 1px solid #d90be1;
    width: 30px;
    height: 30px;
    line-height: 30px;
    border-radius: 50%;
    margin:0 5px;
}
.profile-card-4 i:hover {
  background-color:#d90be1;
  color:#fff;
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
	 
	 $("#wantbook").click(function(){
		 	var formData =  $("#bookform").serialize();
		    $.ajax({
		        url : '${root}/want/insertWantBook.dnb',
		        type : 'GET',
		        contentType : 'application/json;charset=UTF-8',
		        data : formData,
		        success : function() {
		   		 $("#wantbook").attr("class", "btn btn-secondary");
				 $("#wantbook").attr("id", "cancelWantBook");
		      	}  
		   });
	 });
	 
	 $("#cancelWantBook").click(function(){
			 var formData =  $("#bookform").serialize();
			    $.ajax({
			        url : '${root}/want/cancelWantBook.dnb',
			        type : 'GET',
			        contentType : 'application/json;charset=UTF-8',
			        data : formData,
			        success : function() {
			            $("#cancelWantBook").attr("class", "btn btn-outline-secondary");
			            $("#cancelWantBook").attr("id", "wantbook");
			        }  
			    });
		});

	 $("#readbook").click(function(){
			 var formData =  $("#bookform").serialize();
			    $.ajax({
			        url : '${root}/read/insertReadBook.dnb',
			        type : 'GET',
			        contentType : 'application/json;charset=UTF-8',
			        data : formData,
			        dataType : 'json',
			        success : function() {
			            $("#readbook").attr("class", "btn btn-secondary");
			            $("#readbook").attr("id", "cancelReadBook");
			      	}  
			   });
		});

	 $("#cancelReadBook").click(function(){
			var formData =  $("#bookform").serialize();
			    $.ajax({
			        url : '${root}/read/cancelReadBook.dnb',
			        type : 'GET',
			        contentType : 'application/json;charset=UTF-8',
			        data : formData,
			        success : function(data) {
			            $("#cancelReadBook").attr("class", "btn btn-outline-secondary");
			            $("#cancelReadBook").attr("id", "readbook");
			        }  
			    });
		}); 
});

$(document).on("click", "#writeBtn", function() {
    $("#bookform").attr("method", "POST").attr("action", "${root}/post/selectedWrite.dnb").submit();
});


function getList() {
   var isbn = "${book.isbn}";
    var parameter = {"isbn" : isbn};
    $.ajax({
      url : '${root}/info/searchreview.dnb',
      type : 'GET',
      contentType : 'application/json;charset=UTF-8',
      data : parameter,
      dataType : 'json',
      success : function(data) {
         makeList(data);
      }
   });
}

function makeList(review) {
   var rlist = review.postList;
   var output = "";
   for(var i=0;i<rlist.length;i++){
	   if (rlist[i].title != null) {
 	      output +='<div class="abc">';
 	      output +=   '<div class="card profile-card-4">';
	      output +=       '<div class="card-img-block">';
	      if(rlist[i].save_postPicture != null){
	      output +=              '<img class="" src="${root}/upload/album/'+rlist[i].pSaveFolder+'/'+rlist[i].save_postPicture+'" alt="Card image cap" style="width:260px;">';
	      } else{
	      output +=              '<img class="" src="'+rlist[i].bookImg+'" alt="Card image cap" style="width:260px;">';   
	      }
	      output +=       '</div>';
	      output +=       '<div class="card-body pt-5">';
	      output +=             '<img src="${root}/upload/profile/'+rlist[i].mSaveFolder+'/'+rlist[i].save_proPicture+'" alt="profile-image" class="profile"/>';      
	      output +=             '<h5 class="card-title text-center">'+rlist[i].nickname+'</h5>';
	      output +=             '<p class="card-text text-center">'+rlist[i].simpleReview+'</p>';
	      output +=        '</div>';
	      output +=   '</div>';
 	      output +='</div>';
 	
	   }
	}
      $("#book").append(output);
}



</script>
<body>
   <div class="container">
      <div class="row">
<!----------------------------------------------------------------본문내용--------------------------------------------------------------------------------------->
<br>
<!----------------------------------------------------------------책정보 ---------------------------------------------------------------------------------------->
<form id="bookform" method="POST">
<input type="hidden" id="isbn" name="isbn" value="${book.isbn}">
<input type="hidden" id="description" name="description" value="'${book.description}">
<input type="hidden" id="title" name="title" value="${book.title}">
<input type="hidden" id="author" name="author" value="${book.author}">
<input type="hidden" id="publisher" name="publisher" value="${book.publisher}">
<input type="hidden" id="image" name="image" value="${book.image}">
<input type="hidden" id="pubdate" name="pubdate" value="${book.pubdate}">
<table style="border-top:2px solid #888888;border-bottom:2px solid #888888;margin-top:160px;">
<tr>
   <td>
      <img src="${book.image}" style="width:200px;padding-top:20px;padding-bottom:20px">
   </td>
   <td style="padding:20px">
      <h4>${book.title}</h4>
      <p style="color:gray;"> ${book.author}| ${book.publisher} | ${book.pubdate}</p>
      <p>${book.description}</p>
   </td>
   <td align="center">
      <button class="btn btn-outline-secondary" id="writeBtn" style="width:120px;">글쓰기</button>
      <c:set var="wblist" value="${wblist}" />
      <c:set var="rblist" value="${rblist}" />
      <c:set var="bisbn" value="${book.isbn}" />
		
      
       <c:choose>
      	<c:when test="${wblist.indexOf(bisbn) == -1}">
      	    <button class="btn btn-outline-secondary" id="wantbook" style="margin-top:30px;margin-bottom:30px;width:120px;">읽고 싶은 책</button>
      	</c:when>
      	<c:otherwise>
      		<button class="btn btn-secondary" id="cancelWantBook" style="margin-top:30px;margin-bottom:30px;width:120px;">읽고 싶은 책</button>
      	</c:otherwise>
      </c:choose>
      
	   <c:choose>
      	<c:when test="${rblist.indexOf(bisbn) == -1}">
            <button class="btn btn-outline-secondary" id="readbook" style="width:120px;">읽은 책</button>
      	</c:when>
      	<c:otherwise>
      		<button class="btn btn-secondary" id="cancelReadBook" style="width:120px;">읽은 책</button>
      	</c:otherwise>
      </c:choose>
   </td>
</tr>
</table>
</form>
<div id="book" class="col-md-12" style="height:30px;margin-top:50px;"><h2>리뷰</h2></div><br><br>
<!------------------------------------------- 카드 시작--------------------------------  -->

<!-- -----------------------------------------------------여기 위에 각자 뷰 만들기---------------------------------------------------- -->   
      </div><!-- /row -->
   </div> <!-- /container -->
</body>
</html>