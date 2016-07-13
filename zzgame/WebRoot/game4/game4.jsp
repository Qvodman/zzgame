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
		if(rs.getInt("game3_score")<5000){
			out.print("<script>alert('第4关未能解锁！');location.href='../index.jsp';</script>");
			}
		}
		
		int game1_score=0;
		int game2_score=0;
		int game3_score=0;
		int score=0;
		int game4_score=0;//第4关得分传给此变量
		
		sql = "SELECT * FROM user where username=?";
		stmt = dbConn.prepareStatement(sql);
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
		/* sql = "update user set game4_score=? , score=? where username=?";
		stmt = dbConn.prepareStatement(sql);
		stmt.setInt(1,game4_score);
		stmt.setInt(2,score);
		stmt.setString(3,user.getUsername());
		stmt.executeUpdate(); */
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
                height: 600px;
                background-color: #EEEEEE;
            }

        </style>
    </head>

    <body>
        <div id="canvas-frame"></div>
		<canvas 
			id="ScoreCanvas" style="top:10px;left:10px;position: absolute;">
		</canvas> 
		<canvas 
			id="TimeCanvas" style="top:30px;left:10px;position: absolute;">
		</canvas> 
        <script src="js/three_r73.js"></script>
        <script src="js/random.js"></script>
        <script src="js/bullet.js"></script>
        <script src="js/game.js"></script>
        <script>
			var viewer = new Game('canvas-frame', window.innerWidth, window.innerHeight);
        </script>
    </body>
</html>
