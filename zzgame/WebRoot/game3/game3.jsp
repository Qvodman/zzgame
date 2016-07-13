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
		if(rs.getInt("game2_score")<50){
			out.print("<script>alert('第3关未能解锁！');location.href='../index.jsp';</script>");
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

<!DOCTYPE html>
<html>
    <head>
		<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <meta charset="UTF-8">
        <title>WebGL</title>
        <style type="text/css">
            div#canvas-frame {
                border: none;
                cursor: pointer;
                width: 100%;
                height: 200px;
                background-color: #EEEEEE;
            }

        </style>
    </head>

    <body>
		<canvas 
			id="ScoreCanvas" style="top:10px;left:10px;position: absolute;height:40px">
		</canvas>
        <div id="canvas-frame"></div> 
		<button id="ssButton" style="top:10px;right:10px;position: absolute;">Start</button> 
		
		<button id="TopButton"style="position: absolute;background-size: 100% 100%;background-repeat: no-repeat;"></button> 
		<button id="BottomButton"style="position: absolute;background-size: 100% 100%;background-repeat: no-repeat;"></button> 
		<button id="LeftButton"style="position: absolute;background-size: 100% 100%;background-repeat: no-repeat;"></button> 
		<button id="RightButton"style="position: absolute;background-size: 100% 100%;background-repeat: no-repeat;"></button> 
		
        <script src="js/three_r73.js"></script>
        <script src="js/game.js"></script>
        <script>
			var viewer = new Game('canvas-frame', window.innerWidth, window.innerHeight);
        </script>
    </body>
</html>
