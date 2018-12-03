<%@page import="java.net.URLEncoder"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../commons/top.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<style>
.vl {
   border-right: 2px solid grey;
   height: 250px;
   margin-top: 1rem;
}

.container p.lead {
   font-size: 25px;
}

#abc {
   margin-top: 1.5rem;
}

</style>
<script type="text/javascript">
$(document).ready(function() {
   
   getList();

    $(document).scroll(function() {
      var maxHeight = $(document).height();
      var currentScroll = $(window).scrollTop() + $(window).height();
      if (maxHeight <= currentScroll + 100) {
           getList();
      }
    });
});


$(document).on("click", ".writebook", function() {
	 var formnum = $(this).data("formnum");
     $("#bookform"+formnum).attr("method", "POST").attr("action", "${root}/post/selectedWrite.dnb").submit();
});

//상세보기
$(document).on("click", ".bookinfo", function() {
 var formnum = $(this).data("formnum");
 $("#bookform"+formnum).attr("method", "post").attr("action", "${root}/info/info.dnb").submit();
});

$(document).on("click", ".wantbook", function() {
    var formnum = $(this).data("formnum");
 	var formData =  $("#bookform"+formnum).serialize();
    $.ajax({
        url : '${root}/want/insertWantBook.dnb',
        type : 'GET',
        contentType : 'application/json;charset=UTF-8',
        data : formData,
        success : function() {
   		 $(this).attr("class", "btn btn-secondary cancelWantBook");
      	}  
   });
});

$(document).on("click", ".cancelWantBook", function() {
    var formnum = $(this).data("formnum");
 	var formData =  $("#bookform"+formnum).serialize();
    $.ajax({
        url : '${root}/want/cancelWantBook.dnb',
        type : 'GET',
        contentType : 'application/json;charset=UTF-8',
        data : formData,
        success : function() {
            $(this).attr("class", "btn btn-outline-secondary wantbook");
        }  
    });
});

$(document).on("click", ".readbook", function() {
    var formnum = $(this).data("formnum");
 	var formData =  $("#bookform"+formnum).serialize();
    $.ajax({
        url : '${root}/read/insertReadBook.dnb',
        type : 'GET',
        contentType : 'application/json;charset=UTF-8',
        data : formData,
        dataType : 'json',
        success : function() {
            $(this).attr("class", "btn btn-secondary cancelReadBook");
      	}  
   });
});

$(document).on("click", ".cancelReadBook", function() {
    var formnum = $(this).data("formnum");
 	var formData =  $("#bookform"+formnum).serialize();
    $.ajax({
        url : '${root}/read/cancelReadBook.dnb',
        type : 'GET',
        contentType : 'application/json;charset=UTF-8',
        data : formData,
        success : function(data) {
            $(this).attr("class", "btn btn-outline-secondary readbook");
        }  
    });
}); 

function getList() {
    var word = "${word}";
    var parameter = {"word" : word};
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
}

var wblist ="${wblist}";
var rblist ="${rblist}";
var word = "${word}";

function makeList(book) {
   var blist = book.booklist;
   var output = "";
   for(var i=0;i<blist.length;i++){
   var isbn = blist[i].isbn;
   if (blist[i].title != null) {
      output +='<form id="bookform'+i+'">';
      output +=    '<input type="hidden" id="isbn" name="isbn" value="'+blist[i].isbn+'">';
      output +=    '<input type="hidden" id="description" name="description" value="'+blist[i].description+'">';
      output +=    '<input type="hidden" id="title" name="title" value="'+blist[i].title+'">';
      output +=    '<input type="hidden" id="author" name="author" value="'+blist[i].author+'">';
      output +=    '<input type="hidden" id="publisher" name="publisher" value="'+blist[i].publisher+'">';
      output +=    '<input type="hidden" id="image" name="image" value="'+blist[i].image+'">';
      output +=    '<input type="hidden" id="pubdate" name="pubdate" value="'+blist[i].pubdate+'">';
      output +=    '<input type="hidden" id="word" name="word" value="'+word+'">';
      output +=        '<table style="border-top: 0.5px solid #888888;">';
      output +=         '<tr>';
      output +=          '<td>';
      if(blist[i].image == null) {
      output +=             '<img src="${root}/resources/img/blackheart.png" style="width: 200px; padding-top: 20px; padding-bottom: 20px">';
      } else {
      output +=             '<img src="'+blist[i].image+'" style="width: 200px; padding-top: 20px; padding-bottom: 20px">';
      }
      output +=          '</td>';
      output +=          '<td style="padding: 20px; width:720px;">';
      output +=             '<h4><span name="title">"'+ blist[i].title +'"</span></h4>';
      output +=             '<p style="color: gray;">"'+ blist[i].author +'" | "' + blist[i].publisher + '" | "'+ blist[i].pubdate +'" </p> ';
      output +=             '<p>"'+ blist[i].description +'"</p>';
      output +=             '<span class="detail">';
      output +=       	      '<button class="btn btn-link bookinfo" data-formnum="'+i+'" style="width: 120px;">상세보기</button>';
      output +=             '</span>';
      output +=           '</td>';
      output +=           '<td align="center" style="float-left:20px">';
      output +=             '<button class="btn btn-outline-secondary writebook" data-formnum="'+i+'" style="width: 120px;">글쓰기</button>';
      if(wblist.indexOf(isbn) == -1){
      output +=             '<button class="btn btn-outline-secondary wantbook" data-formnum="'+i+'" style="margin-top: 30px; margin-bottom: 30px; width: 120px;">읽고 싶은 책</button>';
      } else {
      output +=             '<button class="btn btn-secondary cancelWantBook" data-formnum="'+i+'" style="margin-top: 30px; margin-bottom: 30px; width: 120px;">읽고 싶은 책</button>';   
      }
      if(rblist.indexOf(isbn) == -1){
      output +=             '<button class="btn btn-outline-secondary readbook" data-formnum="'+i+'" style="width: 120px;">읽은 책</button>';
      } else{
      output +=             '<button class="btn btn-secondary cancelReadBook" data-formnum="'+i+'" style="width: 120px;">읽은 책</button>';  
      }
      output +=        	  '</td>';
      output +=     	 '</tr>';
      output +=   		'</table>';
      output += '</form>';
   }
}
      $("#table").append(output);
}

</script>
</head>
<body>
   <nav id="registerbook" name="registerbook"> <!-- 여기서부터 본문 --> 
   <main role="main">
   <div>
      <br>
      <br>
      <br>
      <br>
   </div>
   <div class="container marketing">
   <h1>도서 목록</h1>
   <hr style="border: solid 1px black;">
   <div>
      <br><br><br><br>
   </div>
       <div id="table">
       
      </div>
    <!-------------------------------- 푸터시작------------------------>
      <hr class="featurette-divider">
      <!-- /END THE FEATURETTES -->
   </div>
   <!-- /.container --> <!-- FOOTER --> <footer class="container">
   <p class="float-right">
      <a href="#">Back to top</a>
   </p>
   <p>
      &copy; 2017-2018 Company, Inc. &middot; <a href="#">Privacy</a>
      &middot; <a href="#">Terms</a>
   </p>
   </footer> </main> </nav>
</body>
</html>