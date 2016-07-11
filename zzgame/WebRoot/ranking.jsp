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
		response.sendRedirect("login.html");
		return;
	}
	user user = (user) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>ZZ小游戏——排行榜</title>
<link rel="stylesheet" href="css/normalize3.0.2.min.css" />
<link rel="stylesheet" href="css/ranking.css?v=15" />
</head>
<body>
	<%
		DB dbc = new DB();
		Connection dbConn = dbc.getConnection();
		PreparedStatement pstat = null;
		ResultSet rs = null;
		String sql = null;
		dbc = new DB();
		dbConn = dbc.getConnection();
		sql = "SELECT * FROM user ORDER BY score DESC";
		Statement stmt = dbConn.createStatement();
		rs = stmt.executeQuery(sql);
		int i = 1;

		out.print("<section id='ranking'>");
		out.print("<span id='ranking_title'>排行榜</span>");
		out.print("<section id='ranking_list'>");

		while (rs.next()) {
		/* 				user user = new user();
		 user.setUsername(rs.getString("username"));
		 user.setPassword(rs.getString("password"));
		 user.setNickname(rs.getString("nickname"));
		 user.setScore(rs.getInt("score")); */
		if (i == 1) {
			if (user.getUsername().equals(rs.getString("username"))) {
				out.print("<section class='box cur'>");
				out.print("<section class='col_1' title='1'>" + i + "</section>");
			} else {
				out.print("<section class='box'>");
				out.print("<section class='col_1' title='1'>" + i + "</section>");
			}
		} else if (i == 2) {
			if (user.getUsername().equals(rs.getString("username"))) {
				out.print("<section class='box cur'>");
				out.print("<section class='col_1' title='2'>" + i + "</section>");
			} else {
				out.print("<section class='box'>");
				out.print("<section class='col_1' title='2'>" + i + "</section>");
			}
		} else if (i == 3) {
			if (user.getUsername().equals(rs.getString("username"))) {
				out.print("<section class='box cur'>");
				out.print("<section class='col_1' title='3'>" + i + "</section>");
			} else {
				out.print("<section class='box'>");
				out.print("<section class='col_1' title='3'>" + i + "</section>");
			}	
		} else {
			if (user.getUsername().equals(rs.getString("username"))) {
				out.print("<section class='box cur'>");
				out.print("<section name='i' id='i' class='col_1'>" + i + "</section>");
			} else {
				out.print("<section class='box'>");
				out.print("<section class='col_1'>" + i + "</section>");
			}
		}
		out.print("<section class='col_2'>");
		out.print("<img src='img/pic.jpg' />");
		out.print("</section>");
		out.print("<section class='col_3'>" + rs.getString("nickname") + "</section>");
		out.print("<section class='col_4'>" + rs.getInt("score") + "</section>");
		out.print("</section>");

		i++;
		}
		out.print("</section>");
		out.print("</section>");
	%>
	<a id="return_back" href="index.jsp" title="返回">返回</a>
</body>
</html>
