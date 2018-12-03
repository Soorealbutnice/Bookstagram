<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../commons/top.jsp"%>
<head>
<!-- font -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo" rel="stylesheet">
  
<style>
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: black; text-decoration: underline;}

#title, #nickname{
   font-family: 'Nanum Myeongjo', serif;
}
#review{
   font-family: 'Nanum Myeongjo', serif;
   font-size:3rem;
   color:darkgray;
}

.media{
    border-top-style: none;
    border-right-style: none;
    border-bottom-style: solid;
    border-left-style: none;
    border-width: 1px;
    border-color: lightgray;
}

.media:hover{
   background-color: #f2f2f2;
}

A:visited {text-decoration:none; color:#646464;}

@media (min-width: 768px) {
  .container {
    width: 800px;
  }
}

@media (min-width: 992px) {
  .container {
    width: 880px;
  }
}

.img{
    position: relative;
    background-image: url("${root}/upload/album/${article.psavefolder}/${article.save_postPicture}");                                                               
    height: 50vh;
    background-size: cover;
}

.img-cover{
   position: absolute;
   height: 100%;
   width: 100%;
   background-color: rgba(0, 0, 0, 0.4);                                                                 
   z-index:1;
}

.img .content{
     position: absolute;
     top:50%;
     left:50%;
     transform: translate(-50%, -50%);     
     font-size : 6rem;                                                              
     color: white;
     z-index: 2;
     text-align: center;
}

#info{
     position: absolute;
     top:90%;
     left:30%;
     transform: translate(-50%, -50%);                                                                   
     color: white;
     z-index: 2;
     text-align: center;
}

#postedImg{
   text-align:center;
}
</style>
<script type="text/javascript">
control = "${root}/post";
initPath();
$(document).ready(function() {
   
   getList();
   //후원하기//
   $("#goPay").click(function() {
     var pay = $("#pay").val();
      var supported_id = $('#articleBody').data("post_id");
      var parameter = {'pay' : pay, 'supported_id' : supported_id};
         IMP.init('imp30810244');
         IMP.request_pay({
           pg : 'kakaopay',
           pay_method : 'card',
           merchant_uid : 'merchant_' + new Date().getTime(),
           name : '후원하기',
           amount : pay ,
             }, 
             function(rsp) {
                if (rsp.success) {
                    var msg = '결제가 완료되었습니다.';
                        msg += '결제 금액 : ' + rsp.paid_amount;
                       $.ajax({
                          url: '${root}/support/insertSupport.dnb', 
                          type: 'GET',
                          contentType : 'application/json;charset=UTF-8',
                           data : parameter,
                           success : function(data) {
                              
                            }
                       });
                   
                } else {
                    var msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                }
                  alert(msg);
           });
   });   
   
   //글 수정, 삭제 //
   $("#modifyBtn").click(function() {
      var post_no = $("#articleBody").data("post_no");
      document.location.href="${root}/post/modify.dnb?post_no="+post_no;
   });
   
   $("#deleteBtn").click(function() {
      if(confirm("글을 삭제하시게습니까?")){
         var post_no = $("#deleteBtn").data("post_no");
         window.location="${root}/post/delete.dnb?post_no="+post_no;
      }
   });
   
   $(document).on("click", ".viewModifyBtn", function() {
         var reply_no = $(this).parent("td").attr("data-post_no");
         $("#div" + reply_no).css("display", "");
   });
   

   //댓글
   function getList() {
      var post_no = $("#articleBody").data("post_no");
      var parameter = {"post_no": post_no};
      $.ajax({
         url : '${root}/reply/listReply.dnb',
         type : 'GET',
         contentType : 'application/json;charset=UTF-8',
         data : parameter,
         dataType : 'json',
         success : function(data) {
            makeList(data);
         }
      });
   }

   function makeList(replys) {
      $("#replyview").empty();
      var rlist = replys.replylist;
      var output = "";
      output += '<label>댓글  '+rlist.length+'</label>';
      output += '<hr>';
      for(var i=0;i<rlist.length;i++) {
         output += '<div id="'+rlist[i].reply_no+'" class="media" data-reply_no="'+rlist[i].reply_no+'" style="padding-top: 20px;">';
         output += '      <img src="${root}/upload/profile/'+rlist[i].saveFolder+'/'+rlist[i].save_proPicture+'" class="mr-3 mt-2 rounded-circle" style="width:60px;">';
         output += '   <div class="media-body mb-3">';
         output += '     <h6><b>'+rlist[i].nickName+'</b>&nbsp;&nbsp;&nbsp;<small><i>'+rlist[i].reply_date+'</i></small></h6>';
         output += '     <p>'+rlist[i].reply_content+'</p>';      
         output += '   </div>';
         if(rlist[i].reply_id == '${userInfo.id}') {
            output += '   <div>';
            output += '      <button class="modifyReply">수정</button>';
            output += '      <button class="deleteReply">삭제</button>';
            output += '   </div>';
         }
         output += '<br>';
         output += '</div>';
         
      }  
         $("#replyview").append(output);
   }

   //댓글 작성, 수정, 삭제 //
   $("#replyBtn").click(function() {
      var post_no = '${article.post_no}';
      var reply_content = $("#reply_content").val();
      $("#reply_content").val('');
      var parameter = JSON.stringify({'post_no' : post_no, 'reply_content' : reply_content});
      if(reply_content.trim().length != 0) {
         $.ajax({
            url : '${root}/reply/writeReply.dnb',
            type : 'POST',
            contentType : 'application/json;charset=UTF-8',
            dataType : 'json',
            data : parameter,
            success : function(data) {
               makeList(data);
            }
         });
      }
   });


   $(document).on("click", ".deleteReply", function() {
      if(confirm("댓글을 삭제하시겠습니까?")) {
         var reply_no = $(this).parent().parent().data("reply_no");
         $.ajax({
            url : '${root}/reply/deleteReply.dnb/'+reply_no,
            type : 'DELETE',
            contentType : 'application/json;charset=UTF-8',
            dataType : 'json',
            success : function(data) {
            }
         });
         alert("삭제가 완료되었습니다.");
         getList();
      }
   });

   $(document).on("click", ".modifyReply", function() {
	   if(confirm("댓글을 수정하시겠습니까?")) {
        var reply_no = $(this).parent().parent().data("reply_no");
       var parameter = {"reply_no": reply_no};
       $.ajax({
            url : '${root}/reply/getReply.dnb',
            type : 'GET',
            contentType : 'application/json;charset=UTF-8',
            data : parameter,
            dataType : 'json',
            success : function(data) {
               makeModifyReplyForm(data);
            }  
      }); 
	 }
   });
   
   function makeModifyReplyForm(reply) {
      var replylist = reply.reply;
      $("#"+replylist[0].reply_no+"").empty();
      
      var output = "";
      output += '   <img src="${root}/upload/profile/'+replylist[0].saveFolder+'/'+replylist[0].save_proPicture+'" class="mr-3 mt-2 rounded-circle" style="width:60px;">';
      output += '   <div class="media-body">';
      output += '     <h6><b>'+replylist[0].nickName+'</b></h6>';
      output += '     <div style="float:left">';
      output += '        <textarea id="modifiedContent" rows="4" style="width:706px" placeholder="내용을 입력해주세요">'+replylist[0].reply_content+'</textarea>';      
      output += '        <button id="modifyComplete" data-reply_no="'+replylist[0].reply_no+'">수정</button>';
      output += '     </div>';
      output += '   </div>';

      $("#"+replylist[0].reply_no+"").append(output);
   }

   $(document).on("click", "#modifyComplete", function() {
      var reply_content = $("#modifiedContent").val();
      var post_no = '${article.post_no}';
      var reply_no = $("#modifyComplete").data("reply_no");
       var parameter = {'post_no' : post_no, 'reply_no' : reply_no, 'reply_content' : reply_content};
       if(reply_content.trim().length != 0) {
         $.ajax({
            url : '${root}/reply/modifyReply.dnb',
            type : 'GET',
            contentType : 'application/json;charset=UTF-8',
            dataType : 'json',
            data : parameter,
            success : function() {
            }
         });
      } 
       alert("수정이 완료되었습니다.");
       getList();
   });


   //해시태그 클릭 ->검색
   $(document).on('click', '.hashtag' , function(){
      var searchWord = $(this).text();
      window.location= "${root}/main/searchMainCome.dnb?searchWord="+searchWord;
   });
});

//구독하기//
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

//프로필 보기//
function mvWriterPage(post_id){
      window.location= "${root}/mypage/mpreview.dnb?post_id="+post_id
}

//해시태그 검색//
function hashtagSearch(word){
      var searchWord = word;
      document.location.href= "${root}/main/searchMainCome.dnb?searchWord="+searchWord;
}

function mvMyPage(followed_id){
   document.location.href= "${root}/mypage/mpreview.dnb?post_id="+followed_id;
}
</script>
</head>
<body>
<br><br><br>
<header>
 <div class="img">
   <div class="content">
       <label id="title">${article.title}</label><br>
       <c:if test="${article.simpleReview != null}">
       <label id="review">"${article.simpleReview}"</label>
       </c:if>
   </div>
   <div class="img-cover">
   </div>
      <div align="right" id="info">
      <h5 id="nickname">by. ${article.nickname}</h5>
         <h6>${article.write_date}</h6>
      </div>
</div>
</header>
<hr>
<div class="container" id="articleBody" data-post_no="${article.post_no}" data-post_id="${article.post_id}">
   <main role="main">
         <div id="selectedBook">
         <c:if test="${article.bookImg != null}">
      <table style="border-top: 1px solid #444444;border-bottom: 1px solid #444444;width:100%;">
         <tr>
             <td>
                  <img src="${article.bookImg}" style="width: 200; padding-top: 20px; padding-bottom: 20px">
            </td>
            <td style="padding: 20px; width:720px;">
                <h4><span>${article.book_name}</span></h4>
                  <p style="color: gray;">${article.bookInfo}</p> 
             </td>
          </tr>
       </table>
       </c:if>
       <br><br>
       <c:if test="${article.save_postPicture != null || article.save_postPicture.trim() != ''}">
       <div id="postedImg">
          <img src="${root}/upload/album/${article.psavefolder}/${article.save_postPicture}" style="width:80%;">
       </div>
       </c:if>
       <br><br>
      </div>
      <c:if test="${article.content ne null}">
         ${article.content}
      </c:if>
      <br><br><br><br><br><br><br>
      <span>
      <c:set var="hashtag1" value="${article.hashtag1}" />
      <c:set var="hashtag2" value="${article.hashtag2}" />
      <c:set var="hashtag3" value="${article.hashtag3}" />
      <c:set var="hashtag4" value="${article.hashtag4}" />
      
      <c:if test="${article.hashtag1 != null && not empty fn:trim(hashtag1)}">
      <label class="hashtag">#<a href="javascript:hashtagSearch('${article.hashtag1}');">${article.hashtag1}</a></label>
      </c:if>
      <c:if test="${article.hashtag2 != null && not empty fn:trim(hashtag2)}">
      <label class="hashtag">#<a href="javascript:hashtagSearch('${article.hashtag2}');">${article.hashtag2}</a></label>
      </c:if>
      <c:if test="${article.hashtag3 != null && not empty fn:trim(hashtag3)}">
      <label class="hashtag">#<a href="javascript:hashtagSearch('${article.hashtag3}');">${article.hashtag3}</a></label>
      </c:if>
      <c:if test="${article.hashtag4 != null && not empty fn:trim(hashtag4)}">
      <label class="hashtag">#<a href="javascript:hashtagSearch('${article.hashtag4}');">${article.hashtag4}</a></label>
         </c:if>
      </span>
         <hr>
      <div align="right">
        <c:if test="${article.post_id == userInfo.id}">
          <br>
           <button id="modifyBtn" class="btn btn-outline-secondary" data-post_no="${article.post_no}">글수정</button>
           <button id="deleteBtn" class="btn btn-outline-secondary" data-post_no="${article.post_no}">글삭제</button>
        <br><br>
        </c:if>
        </div>   
          <!--------------------- 글 작성자 프로필--------------------->  
         <div>       
             <div class="border p-4">
              <div align="center">
                    <img src="${root}/upload/profile/${article.saveFolder}/${article.save_proPicture}" class="align-self-start mb-3 rounded-circle"style="width:100px">
                   <a href="javascript:mvMyPage('${article.post_id}');"><h4>${article.nickname}</h4></a> 
                <div>
                   <p>${article.introduce}</p>
                </div>
                
                <c:if test="${followStatus.follow_no == null}">
                   <button id="followBtn" onclick="javascript:follow('${article.post_id}');"  class="btn btn-outline-secondary"  style="height:40px;">구독하기</button> 
                </c:if>
                 <c:if test="${followStatus.follow_no != null}">
                   <button id="cancelFollowBtn" onclick="javascript:cancelFollow('${article.post_id}');"  class="btn btn-secondary"  style="height:40px;">구독중</button> 
                </c:if>
                <button id="mvWriterPage" class="btn btn-outline-secondary" onclick="javascript:mvWriterPage('${article.post_id}');" style="height:40px;">프로필보기</button>
                
                <!--- 후원하기 --->    
                <button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#myModal1">후원하기</button>
                 <!-- The Modal -->
                 <div class="modal" id="myModal1">
                   <div class="modal-dialog">
                     <div class="modal-content">
                       <!-- Modal Header -->
                       <div class="modal-header">
                         <h4 class="modal-title">후원하기</h4>
                         <button type="button" class="close" data-dismiss="modal">&times;</button>
                       </div>
                       
                       <!-- Modal body -->
                       <div class="modal-body">
                        ${article.nickname} 님<br>
                        <input type="text" id ="pay">원
                        </div>
                        <!-- Modal footer -->
                        <div class="modal-footer">
                          <button type="button" class="btn btn-danger" data-dismiss="modal" id="goPay">KakaoPay결제</button>
                          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                       </div>
                     </div>
                    </div>
                   </div>
                </div>  <!-- <div align="center"> -->
              </div> <!--<div class="border p-4">-->
            <hr/>
         <div id="replyview">
         </div>
         
            <!---- 댓글 작성창------>
              <div class="media border p-3">
                <div class="media-body">
                     <textarea class="form-control" rows="4" placeholder="내용을 입력해주세요" id="reply_content"></textarea>
                  </div>
                  <div>
                  <button id="replyBtn"  style="margin-left: 13px;">등록</button>
                 </div>
              </div>
            <br>
       </div>
</main>
</div> <!-- /container -->
</body>
</html>