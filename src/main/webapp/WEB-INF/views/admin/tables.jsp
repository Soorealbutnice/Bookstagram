<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/admin.jsp"%>
<!-- 페이징 관련 데이터들 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>DNB Admin</title>
    <!-- Bootstrap core CSS-->
    <link href="${root}/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template-->
    <link href="${root}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <!-- Page level plugin CSS-->
    <link href="${root}/resources/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
    <!-- Custom styles for this template-->
    <link href="${root}/resources/css/sb-admin.css" rel="stylesheet">
    
<script type="text/javascript">
$(document).ready(function() {
 	getList("", "");
 
	$("#searchBtn").click(function(){
		getList($("#key").val(), $("#word").val());	
	});

});

function getList(key, word){

	$.ajax({
		type : "GET",
		url : "${root}/admin/memberlist.dnb",
		dataType : "json",
		data : {"key" : key, "word" : word},
		success : function(data){
			makeList(data);
		},
		error : function(e){
			
		}
	});
}
function makeList(data){
	$("#memberlist").empty();//빈공간으로 만들어라 지워라는안됨
	var members = data.mlist;
	var view ="";//맴버스의 i객체가 순서ㅏ를 나타내는거임
	for(var i=0;i<members.length;i++){
		view +="<tr>";
		view +="<td>" +members[i].name+"</td>";
		view +="<td>" +members[i].id+"</td>";
		view +="<td>" +members[i].email+"</td>";
		view +="<td>" +members[i].nickname+"</td>";
		view +="<td>" +members[i].joindate+"</td>";
 		view +='<td><button data-id="'+members[i].id+'" class="deleteBtn">삭제</button></td>';
 		view +="</tr>";
	}
	$("#memberlist").append(view);
	//얻어와서 
	//위에있는걸 추가시켜주는거임,그럼검색하고나서 한개만띄워야하니까 지워라를 해야댐
}

$(document).on('click','.deleteBtn', function(){
	var id = $(this).data("id");
	window.location="${root}/myup/admindelete.dnb?id="+id;	
});
</script>

  </head>
  <body id="page-top">

    <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

      <a class="navbar-brand mr-1" href="#">DNB Admin</a>

      <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
        <i class="fas fa-bars"></i>
      </button>

   <!--  <!-- Navbar Search 0-->
         <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
        <div class="input-group">
          <div class="input-group-append">

          </div>
        </div>
      </form>  -->

      <!-- Navbar -->
      <ul class="navbar-nav ml-auto ml-md-0">
        <li class="nav-item dropdown no-arrow">
          <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-user-circle fa-fw"></i>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">

            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="${root}/login/logout.dnb">Logout</a>
          </div>
        </li>
      </ul>

    </nav>

    <div id="wrapper">

    <ul class="sidebar navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="${root}/admin/member.dnb">
            <i class="fas fa-fw fa-table"></i>
            <span>Tables</span></a>
        </li>
      </ul>


      <div id="content-wrapper">

        <div class="container-fluid">
          <!-- DataTables Example -->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-table"></i>
              DNB 회원관리</div>
            <div class="card-body">
              <div class="table-responsive">
              <table width="1000" class="table table-bordered" id="dataTable" cellspacing="0" align="center">
				<tr>
					<td align= "right">
						<select name= "key" id= "key">
							<option value= "id">아이디
							<option value= "nickname">닉네임
						</select>
						<input type= "text" name= "word" id= "word">
						<input type= "button" value= "검색" id="searchBtn">
					</td>
				</tr>
				</table>
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Name</th>
                      <th>ID</th>
                      <th>Email</th>
                      <th>Nickname</th>
                      <th>JoinDate</th>
                      <th>관리</th>
                    </tr>
                  </thead>
				  <tbody id="memberlist"></tbody>
                </table>
              </div>
            </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
          </div>

          <p class="small text-center text-muted my-5">
            <em>More table examples coming soon...</em>
          </p>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- /.content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>


    <!-- Bootstrap core JavaScript-->
    <script src="${root}/resources/vendor/jquery/jquery.min.js"></script>
    <script src="${root}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${root}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="${root}/resources/vendor/datatables/jquery.dataTables.js"></script>
    <script src="${root}/resources/vendor/datatables/dataTables.bootstrap4.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${root}/resources/js/sb-admin.min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="${root}/resources/js/demo/datatables-demo.js"></script>

  </body>

</html>
