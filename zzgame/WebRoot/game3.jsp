<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="DAO.*"%>
<%@ page import="DB.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
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
		sql = "SELECT * FROM user where username=?";
		PreparedStatement stmt = dbConn.prepareStatement(sql);
		stmt.setString(1,user.getUsername());
		rs = stmt.executeQuery();
		while (rs.next()) {
		if(rs.getInt("game2_score")<5000){
			out.print("<script>alert('第3关未能解锁！');location.href='index.jsp';</script>");
			}
		}
		
		int game3_score=0;//第3关得分传给此变量
		
		//向数据库传入得分
		sql = "update user set game3_score=? where username=?";
		stmt = dbConn.prepareStatement(sql);
		stmt.setInt(1,game3_score);
		stmt.setString(2,user.getUsername());
		stmt.executeUpdate();		
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'game3.jsp' starting page</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
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
    This is my JSP page. <br>
  </body>
</html>
