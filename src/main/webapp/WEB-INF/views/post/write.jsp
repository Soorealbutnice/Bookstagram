<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.net.URLEncoder"%>
<%@ include file="/WEB-INF/views/commons/top.jsp"%>  

<!-- 아래 cdn코드를 삽입했더니 summernote의 css가 적용됨 -->
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
 
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.js"></script>

 <!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> 

<!-- font -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo" rel="stylesheet">
     
<script>
control = "${root}/post";
initPath();

$(document).ready(function() {
   $("#writeBtn").click(function() {
      if($("#title").val() == "") {
         alert("한줄평을 입력해주세요!!!");
         return;
      } else if ($('.summernote').summernote('isEmpty')) {
         alert("내용 입력해주세요 !!");
         return;   
      } else {
         var bookTitle = $("#sBookTitle").val();
         var bookImg = $("#sBookImg").attr("src");
         var bookInfo = $("#sBookInfo").val();
         
       $("#bookTitle").val(bookTitle);
       $("#bookimg").val(bookImg);
       $("#bookinfo").val(bookInfo);
         $("#writeForm").attr("method", "post").attr("action",writepath).submit();                                  
      }
   });
   
    $('.summernote').summernote({
        placeholder: '글 내용을 입력해주세요',
        tabsize: 2,
        height: 500,
        callbacks: {
             onImageUpload: function(files, editor, welEditable) {
               for (var i = files.length - 1; i >= 0; i--) {
                 sendFile(files[i], this);
               }
             }
        }
   });
    
    $("#bookSearch").click(function(){
       var bookName = $("#bookName").val();
          var parameter = {"word" : bookName};
          $.ajax({
            url : '${root}/info/search.dnb',
            type : 'GET',
            contentType : 'application/json;charset=UTF-8',
            data : parameter,
            dataType : 'json',
            success : function(data) {
               makeList(data);
            }
         });
    });  
}); 

function makeList(book) {
   $("#bookList").empty();
      var blist = book.booklist;
      var output = "";
      for(var i=0;i<blist.length;i++){
      if (blist[i].title != null) {   
         output +=        '<table class="searchBookSection" id="'+ blist[i].isbn +'" style="border-top: 0.5px solid #888888;margin-left:20px;margin-right:20px;">';
         output +=           '<tr>';
         output +=              '<td>';
         if(blist[i].image == null) {
            output +=             '<img src="${root}/resources/img/blackheart.png" style="width:120px; padding-top: 20px; padding-bottom: 20px">';
         } else {
            output +=             '<img src="'+blist[i].image+'" style="width: 120; padding-top: 20px; padding-bottom: 20px">';
         }
         output +=           '</td>';
         output +=           '<td style="padding: 20px; width:720px;">';
          output +=              '<h4><span name="title">"'+ blist[i].title +'"</span></h4>';
          output +=              '<p style="color: gray;">"'+ blist[i].author +'" | "' + blist[i].publisher + '" | "'+ blist[i].pubdate +'" </p> ';
          output +=          '</td>';
          output +=          '<td align="center" style="float-left:20px">';
          output +=             '<input type="button" value="책선택" class="selectThisBook" style="width: 120px;"';
          output +=             'data-title="'+ blist[i].title +'" data-image="'+blist[i].image+'" data-isbn="'+blist[i].isbn+'" data-bookinfo="'+ blist[i].author +' | ' + blist[i].publisher +' | ' + blist[i].pubdate+'" data-dismiss="modal">';
          output +=          '</td>';
          output +=      '</tr>';
          output +=   '</table>';
      }
   }
         $("#bookList").append(output);
}

$(document).on('click', '.selectThisBook', function(){
    $("#selectedBook").empty();
   var title = $(this).data("title");
   var bookinfo = $(this).data("bookinfo");
   var image = $(this).data("image");
   var isbn = $(this).data("isbn");
   var output = "";
   
   output +=        '<input type="hidden" name="bookImg" value="'+image+'">';
   output +=        '<input type="hidden" name="book_name" value="'+title+'">';
   output +=        '<input type="hidden" name="bookInfo" value="'+bookinfo+'">';
   output +=        '<input type="hidden" name="isbn" value="'+isbn+'">';
   output +=        '<table>';
    output +=           '<tr>';
    output +=              '<td>';
      output +=                 '<img id="sBookImg"src="'+image+'" style="width: 200; padding-top: 20px; padding-bottom: 20px">';
   output +=              '</td>';
   output +=              '<td style="padding: 20px; width:720px;">';
    output +=                  '<h4><span id="sBookTitle" name="sBookTitle">"'+ title +'"</span></h4>';
    output +=                  '<p style="color: gray;" id="sBookInfo" name="sBookInfo">"'+bookinfo+'" </p> ';
    output +=                '</td>';
    output +=            '</tr>';
    output +=       '</table>';
   
    $("#selectedBook").append(output);

});
</script>
<style>
#title, #simpleReview{
   font-family: 'Nanum Myeongjo', serif;
}

input:focus {
    outline:none;
}

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

::-webkit-input-placeholder { /* Chrome/Opera/Safari */
  color: #cccccc;
}

:-ms-input-placeholder { /* IE 10+ */
  color: #cccccc;
}

.searchBookSection:hover{
   background-color: #f2f2f2;
}
</style>
</head>
<body>
<br>
<br>
<br>
<form id="writeForm" name="writeForm" method="post" action="" enctype="multipart/form-data">
<div id="attach_file_hdn"></div>
   <header class="header">
       <div class="container">
                <div class="mb-3">
                   <input type="text"  id="title" name="title" placeholder="제목을 입력하세요." style="height:100px;width:100%;font-size:40pt;border:0px;" maxlength="30">
                </div>
                <div>
                   <input type="text" id="simpleReview" name="simpleReview" placeholder="한줄평을 입력하세요." style="color:#999999;height:100px;width:80%;font-size:20pt;border:0px;" maxlength="200">
                </div>
                <div class="mb-3">
                   <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalLong">책검색</button>
                </div>
                   
                <!-- Modal -->
            <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
              <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">책 검색</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                      <div class="input-group mb-3">
                           <input id="bookName" type="search" class="form-control" placeholder="검색할 책을 입력하세요">
                          <div class="input-group-append">
                             <input type="button" id="bookSearch" class="btn btn-success" value="검색">
                          </div>
                      </div>
                  </div>
                  <div id="bookList">
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
   </header>
<hr/>
    <div class="container">
      <main role="main">
            <div id="selectedBook">
            <c:if test="${selectedBook.book_name != null}">
             <input type="hidden" name="bookImg" value="${selectedBook.bookImg}">
            <input type="hidden" name="book_name" value="${selectedBook.book_name}">
            <input type="hidden" name="bookInfo" value="${selectedBook.bookInfo}">
            <input type="hidden" name="isbn" value="${selectedBook.isbn}">
            <table>
               <tr>
                   <td>
                        <img id="sBookImg"src="${selectedBook.bookImg}" style="width: 200; padding-top: 20px; padding-bottom: 20px">
                  </td>
                  <td style="padding: 20px; width:720px;">
                        <h4><span>"${selectedBook.book_name}"</span></h4>
                         <p style="color: gray;">${selectedBook.bookInfo}</p> 
                   </td>
                </tr>
             </table>
         </c:if>
         </div>
            <textarea name="content" id="content" class="summernote" style="border:0px;"></textarea>     
            <br>
            <div class="form-group row">
                <div class="col-3 mb-3">
                  <input class="form-control" id="hashtag1" name="hashtag1" type="text" placeholder="#">
                </div>
                <div class="col-3">
                  <input class="form-control" id="hashtag2" name="hashtag2" type="text" placeholder="#">
                </div>
                <div class="col-3">
                  <input class="form-control" id="hashtag3" name="hashtag3" type="text" placeholder="#">
                </div>
                <div class="col-3">
                  <input class="form-control" id="hashtag4" name="hashtag4" type="text" placeholder="#">
                </div>
            </div>
            <br>
            <h5>메인에 들어갈 사진을 선택해주세요</h5>
            <hr>
            <input type="file" name="picture" id="picture" placeholder="메인에 들어갈 사진을 선택해주세요">
            <hr>
         <div align="right">
            <button type="submit" class="btn btn-outline-dark mr-2" id="writeBtn">글쓰기</button>
            <button type="reset" class="btn btn-outline-dark">취소</button>
         </div>
      </main>
    </div> <!-- /container -->
</form>    
</body>
</html>