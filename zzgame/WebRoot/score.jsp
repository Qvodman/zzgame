<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="DAO.*"%>
<%@ page import="DB.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	if (session.getAttribute("user") == null) {
		response.sendRedirect("../login.html");
		return;
	}
		user user = (user) session.getAttribute("user");
		DB dbc = new DB();
		Connection dbConn = dbc.getConnection();
		ResultSet rs = null;
		String sql = null;
		dbc = new DB();
		dbConn = dbc.getConnection();
		String game = request.getParameter("game");
		if(game.equals("game1")){
			int game1_score = Integer.parseInt(request.getParameter("game1_score"));
			sql = "update user set game1_score=? where username=?";
			PreparedStatement stmt = dbConn.prepareStatement(sql);
			stmt.setInt(1,game1_score);
			stmt.setString(2,user.getUsername());
			stmt.executeUpdate();
			response.sendRedirect("../zzgame/game1/gameover.html");
			
		}
		
		if(game.equals("game2")){
			int game2_score = Integer.parseInt(request.getParameter("game2_score"));
			sql = "update user set game2_score=? where username=?";
			PreparedStatement stmt = dbConn.prepareStatement(sql);
			stmt.setInt(1,game2_score);
			stmt.setString(2,user.getUsername());
			stmt.executeUpdate();
			
		}
		
		if(game.equals("game3")){
			int game3_score = Integer.parseInt(request.getParameter("game3_score"));
			sql = "update user set game3_score=? where username=?";
			PreparedStatement stmt = dbConn.prepareStatement(sql);
			stmt.setInt(1,game3_score);
			stmt.setString(2,user.getUsername());
			stmt.executeUpdate();
			
		}
		
		if(game.equals("game4")){
		int game1_score =0;
		int game2_score =0;
		int game3_score =0;
		int game4_score = Integer.parseInt(request.getParameter("game4_score"));
		int score=0;
		
	
		
		sql = "SELECT * FROM user where username=?";
		PreparedStatement stmt = dbConn.prepareStatement(sql);
		stmt.setString(1,user.getUsername());
		rs = stmt.executeQuery();
		while (rs.next()) {
			game1_score=rs.getInt("game1_score");
			game2_score=rs.getInt("game2_score");
			game3_score=rs.getInt("game3_score");
			score=rs.getInt("score");
		}
		
		
		score = game1_score + game2_score + game3_score + game4_score;
		//向数据库传入得分
		sql = "update user set game4_score=? , score=? where username=?";
		stmt = dbConn.prepareStatement(sql);
		stmt.setInt(1,game4_score);
		stmt.setInt(2,score);
		stmt.setString(3,user.getUsername());
		stmt.executeUpdate();
		response.sendRedirect("../zzgame/index.jsp");
		}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <body>
  </body>
</html>
