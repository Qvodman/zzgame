<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
if(session.getAttribute("user")== null){  			
  				response.sendRedirect("login.html");  					
  				return ;
}
%>

<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta charset="utf-8">
    <title>ZZ小游戏</title>
    <meta name="description" content="slick Login">
    <meta name="author" content="Webdesigntuts+">
    <link rel="stylesheet" type="text/css" href="css/index.css" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="http://www.modernizr.com/downloads/modernizr-latest.js"></script>
    <script type="text/javascript" src="placeholder.js"></script>
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->

  </head>
  
  <body>
    <div id="games">
        <div><img src="img/logo.png" alt="ZZ小游戏" /></div>
    	<br />
    	<br />
        <button onclick="game1()" >暴&nbsp;打&nbsp;地&nbsp;鼠</button>
        <button class="fa fa-lock" onclick="game2()" >&nbsp;火&nbsp;眼&nbsp;金&nbsp;睛</button>
        <button class="fa fa-lock" onclick="game3()" >&nbsp;&nbsp;&nbsp;Z&nbsp;&nbsp;Z&nbsp;&nbsp;旋&nbsp;舞</button>
        <button class="fa fa-lock" onclick="game4()" >&nbsp;隐&nbsp;藏&nbsp;关&nbsp;卡</button>
        <button onclick="ranking()" >&nbsp;排&nbsp;行&nbsp;榜</button>
        <form id="logout" method="post" action="logoutservlet">
    		<input type="submit" value="注&nbsp;销">
    	</form>
    </div>

  </body>
  <script type="text/javascript">
	function game1()
	{
    	window.location.href="game1/game1.jsp";
	}
	function game2()
	{
    	window.location.href="game2/game2.jsp";
	}	
	function game3()
	{
    	window.location.href="game3.jsp";
	}	
	function game4()
	{
    	window.location.href="game4.jsp";
	}
	function ranking()
	{
    	window.location.href="ranking.jsp#i";
	}			
  </script>
</html>
