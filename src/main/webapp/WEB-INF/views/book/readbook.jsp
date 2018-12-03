<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../commons/top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- font -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo" rel="stylesheet">
</head>
<style>
.readBook{
  display: inline-block;
  margin-right:10px;
  margin-left:10px;
  margin-bottom:10px;
  width:13rem;
}

.readBook img{
  width:100%;
  height:100%;
  border-top-left-radius: 0.2rem;
  border-top-right-radius: 0.2rem;
  border-left:1px solid rgba(0,0,0,0.3);
  border-right:1px solid rgba(0,0,0,0.3);
  border-bottom:1px solid rgba(0,0,0,0.3);
  border-top:1px solid rgba(0,0,0,0.3);
  display: block;
}

.readBook h3{
  border-left:1px solid rgba(0,0,0,0.3);
  border-right:1px solid rgba(0,0,0,0.3);
  border-bottom:1px solid rgba(0,0,0,0.3);
  border-bottom-left-radius: 0.2rem;
  border-bottom-right-radius: 0.2rem;
  padding:1rem;
  text-align: center;
  background-color: rgba(255,255,255,0.1);
  color:black;
  font-size:0.8rem;
  font-weight: 200;
}

h2{
	color : black;
	font-family: 'Nanum Myeongjo', serif;
	margin-top : 160px;
	
}

hr{
    border: 0;
    height: 1px;
    background-image: linear-gradient(to right, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.75), rgba(0, 0, 0, 0));
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
  })
  
});

function getList() {
	 var rbook_no = $(".readBook").last().data("rbook_no");
	 if(rbook_no == null){
		 rbook_no = 0;
	 } 
	 var parameter = {"rbook_no" : rbook_no};
	 $.ajax({
		url : '${root}/read/listReadBook.dnb',
		type : 'GET',
		contentType : 'application/json;charset=UTF-8',
		data : parameter,
		dataType : 'json',
		success : function(data) {
			makeList(data);
		}
	});
}

function makeList(rbook) {
	var rblist = rbook.readBookList;
	var output = "";
	for(var i=0;i<rblist.length;i++){
		output +=	'<div class="readBook" data-rbook_no="'+rblist[i].rbook_no+'">';
		output +=	'	<img src="'+rblist[i].rbook_pic+'" />';
		output +=	'	<h3>'+rblist[i].rbook_title+'<br>-'+rblist[i].rbook_author+'</h3>';
		output +=	'</div>';
	}
	
	$("#bookList").append(output);
}
</script>
<body>
<br>
<main role="main">
	<div class="container">
			<div class="row">
				<div>
					<h2>읽은 책</h2>&nbsp;<br>
				</div>
			</div>
				<hr><br>
			<div id="bookList">
<!-- ------------------------------------------------여기 아래에 각자 뷰 만들기--------------------------------------------------------- -->

<!-------------------------------------------------------여기 위에 각자 뷰 만들기------------------------------------------------------->	
			</div>
		</div><!-- /row -->
	</div> <!-- /container -->
</main>
</body>
</html>