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
<script src="http://www.chartjs.org/dist/2.6.0/Chart.bundle.js"></script>
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
      <div><br><br><br><br><br></div>
  	  	<div class="container marketing">
        	<div class="container marketing pro">
	         	<div class="row justify-content-center">
	            <a href="${root}/chart/listreadbook.dnb" class="a">독서</a>
	        	<a href="${root}/chart/writereview.dnb" class="a">리뷰</a>
	        	</div>
     	    </div>
      		<div>
      		<br><br>
      		</div>
      		<h3>올해의 독서</h3>
       		<hr class="featurette-divider">
            <div class="row featurette">
           		<div id="container" style="width:100%;height:300px;margin-bottom:10px;">  
      		 		<canvas id="canvas" style="margin-left: 5px;"></canvas>
           		</div>
       		    <hr class="featurette-divider">
      		</div>
</nav>
<div>
<br><br><br><br><br>
</div>
</main>
<script type="text/javascript">
        var ChartHelper = {
            chartColors: {
                red: 'rgb(255, 99, 132)',
                orange: 'rgb(255, 159, 64)',
                yellow: 'rgb(255, 205, 86)',
                green: 'rgb(75, 192, 192)',
                blue: 'rgb(54, 162, 235)',
                purple: 'rgb(153, 102, 255)',
                grey: 'rgb(201, 203, 207)'
            }
        };

        var color = Chart.helpers.color;

        var data1 = null;
        var data2 = null;
        var barChartData = null;

         data1 = [${listreadbook["M1"]}, ${listreadbook["M2"]}, ${listreadbook["M3"]}, ${listreadbook["M4"]}, ${listreadbook["M5"]}, 
                    ${listreadbook["M6"]}, ${listreadbook["M7"]}, ${listreadbook["M8"]}, ${listreadbook["M9"]}, ${listreadbook["M10"]}, 
                    ${listreadbook["M11"]}, ${listreadbook["M12"]}];

         data2 = [${listavgbook["M1"]}, ${listavgbook["M2"]}, ${listavgbook["M3"]}, ${listavgbook["M4"]}, ${listavgbook["M5"]}, 
             ${listavgbook["M6"]}, ${listavgbook["M7"]}, ${listavgbook["M8"]}, ${listavgbook["M9"]}, ${listavgbook["M10"]}, 
             ${listavgbook["M11"]}, ${listavgbook["M12"]}];
        barChartData = {
            labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
            , datasets: [
                {
                    label: '나의 독서', 
                    backgroundColor: color(ChartHelper.chartColors.blue).alpha(0.5).rgbString(),
                    borderColor: ChartHelper.chartColors.blue,
                    borderWidth: 1,
                    data: data1
                }
                , {
                    label: '평균 독서',
                    backgroundColor: color(ChartHelper.chartColors.red).alpha(0.5).rgbString(),
                    borderColor: ChartHelper.chartColors.red,
                    borderWidth: 1,
                    data: data2
                }
            ]
        };

        var ctx = document.getElementById('canvas').getContext('2d');

        window.BarChart = new Chart(ctx, {
            type: 'bar'
            , data: barChartData
            , options: {
                responsive: true
                , maintainAspectRatio: false
                , legend: {
                    position: 'top'
                }
                  , scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero:true
                                , callback: function (value) {
                                    if (0 === value % 1) {
                                        return value;
                                    }
                                }
                            }
                        }]
                    }
            }
        });

        var colorNames = Object.keys(ChartHelper.chartColors);
</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
</body>
</html>