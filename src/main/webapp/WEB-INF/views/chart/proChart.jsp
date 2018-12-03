<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../commons/top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
 <head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../../../favicon.ico">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script src="http://www.chartjs.org/dist/2.6.0/Chart.bundle.js"></script>   
</head> 
<style>
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
</style>
</head>
<body>
<nav id="graph" name="graph">
    <main role="main">
      <div>
      <br><br><br><br><br>
      </div>  
  		<div class="container marketing" >
       		<div class="container marketing pro">
	        	<div class="row justify-content-center">
	          		<a href="${root}/chart/listreadbook.dnb" class="a">독서</a>
	           		<a href="${root}/chart/writereview.dnb" class="a">리뷰</a>
	         	</div>
      		</div>
      		<div>
      			<br><br><br>
      		</div>
      		<h3>내가독서왕</h3>
        	<hr class="featurette-divider">
            <div class="row featurette">
	       	   	<div id="container" style="float:left;width:35%;height:200px;margin-bottom:10px;">
	        		<canvas id="myChart" style="margin-left: 100px;"></canvas>
	            </div>
			    <div id="container" style="float:left; width: 35%; 
			      height: 200px; margin-bottom: 10px;">
			        <canvas id="Chart" style="margin-left: 250px;"></canvas>
			    </div>
    		</div>
    	</div><!-- /.container -->
    </main>
 </nav>
<script>
   var ctx = document.getElementById('myChart').getContext('2d');
   var chart = new Chart(ctx, {
       type: 'pie',
       data: {
          labels: ["January", "February"],
           datasets: [{
               label: "awerfawef",
               backgroundColor:["rgb(255,200,130)", "rgb(55,150,10)"],
               borderColor: "rgb(255,200,130)", 
               data: [${avgreadbook["PP"]}, ${myreadbook["P.POST_NO"]}],
           }],
       },
       
       options: {
          responsive: true
           , maintainAspectRatio: true
           , legend: {
               position: 'bottom'
           }
           , title: {
               display: true
               , text: 'Chart Title',
               position: 'bottom'
           }  
       }
   });
   

   var ctx = document.getElementById('Chart').getContext('2d');
   var chart = new Chart(ctx, {
       // The type of chart we want to create
       type: 'doughnut',

       // The data for our dataset
       data: {
           labels: ["January", "February"],
           datasets: [{
               label: "My First dataset",
               backgroundColor:["rgb(255,200,130)", "rgb(155,100,130)"],
               borderColor: "rgb(255,200,130)", 
               data: [${avgreadbook["RR"]}, ${myreadbook["R.RBOOK_NO"]}],
           }]
       },

       // Configuration options go here
       options: {
          responsive: true   //auto size : true
           , maintainAspectRatio: true
           , legend: {
               position: 'bottom'
           }
           , title: {
               display: true
               , text: 'Chart Title',
               position: 'bottom'
           }
       }
   });
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
</body>
</html>