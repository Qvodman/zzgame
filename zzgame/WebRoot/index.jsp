<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="DAO.*"%>
<%@ page import="DB.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
if(session.getAttribute("user")== null){  			
  				response.sendRedirect("login.html");  					
  				return ;
}
		user user = (user) session.getAttribute("user");
		DB dbc = new DB();
		Connection dbConn = dbc.getConnection();
		ResultSet rs = null;
		String sql = null;
		dbc = new DB();
		dbConn = dbc.getConnection();
		int game1_score =0;
		int game2_score =0;
		int game3_score =0;
		int game4_score =0;		
		sql = "SELECT * FROM user where username=?";
		PreparedStatement stmt = dbConn.prepareStatement(sql);
		stmt.setString(1,user.getUsername());
		rs = stmt.executeQuery();
		while (rs.next()) {
			game1_score=rs.getInt("game1_score");
			game2_score=rs.getInt("game2_score");
			game3_score=rs.getInt("game3_score");
			game4_score=rs.getInt("game4_score");
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
    	<%out.print("<button onclick='game1()' >暴&nbsp;打&nbsp;地&nbsp;鼠</button>"); %>
    	<%if(game1_score<50){
 			out.print("<button class='fa fa-lock' onclick='game2()' >&nbsp;火&nbsp;眼&nbsp;金&nbsp;睛</button>");
    	 }else{
    	 	out.print("<button onclick='game2()' >&nbsp;火&nbsp;眼&nbsp;金&nbsp;睛</button>");
    	 }
    	 %>
    	<%if(game2_score<50){
 			out.print("<button class='fa fa-lock' onclick='game3()' >&nbsp;&nbsp;&nbsp;Z&nbsp;&nbsp;Z&nbsp;&nbsp;旋&nbsp;舞</button>");
    	 }else{
    	 	out.print("<button onclick='game3()' >&nbsp;&nbsp;&nbsp;Z&nbsp;&nbsp;Z&nbsp;&nbsp;旋&nbsp;舞</button>");
    	 }
    	 %>
    	<%if(game3_score<50){
 			out.print("<button class='fa fa-lock' onclick='game4()' >&nbsp;星&nbsp;球&nbsp;大&nbsp;战</button>");
    	 }else{
    	 	out.print("<button onclick='game4()' >&nbsp;星&nbsp;球&nbsp;大&nbsp;战</button>");
    	 }
    	 %>
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
    	window.location.href="game3/game3.jsp";
	}	
	function game4()
	{
    	window.location.href="game4/game4.jsp";
	}
	function ranking()
	{
    	window.location.href="ranking.jsp#i";
	}			
  </script>
</html>
