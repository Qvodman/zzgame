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
		if(rs.getInt("game1_score")<50){
			out.print("<script>alert('第2关未能解锁！');location.href='../index.jsp';</script>");
			}
		}
		
		int game2_score=0;//第2关得分传给此变量
		
		//向数据库传入得分
		/* sql = "update user set game2_score=? where username=?";
		stmt = dbConn.prepareStatement(sql);
		stmt.setInt(1,game2_score);
		stmt.setString(2,user.getUsername());
		stmt.executeUpdate();	 */	
%>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="-1">
<title>火眼金睛</title>
<link rel="stylesheet" href="assets/css/m.css">
</head>
<body>
<div class="grid">
  <div class="page hide" id="loading"> loading... </div>
  <div class="page hide" id="index">
    <h1>游戏二</h1>
    <div id="help">找出所有色块里颜色不同的一个</div>
    <div class="btns">
      <button data-type="color" class="btn play-btn"> 开始游戏 </button>
    </div>
  </div>
  <div class="page hide" id="room">
    <header> 
      <span class="lv"> 得分： <em> 0 </em> </span> 
      <span class="time"> </span> 
      <span class="btn btn-pause"> 暂停 </span> 
    </header>
    <div id="box_pass">规定分数：50</div>
    <div id="box_mage"></div>
    <div id="box" class="lv1"> </div>
  </div>
  <div class="page hide" id="dialog">
    <div class="inner">
      <div class="content gameover">
        <h3></h3>
        <div class="btn-wrap">
          <button class="btn btn-restart"> 再来一次 </button>
          <button class="btn btn-back"> 返回 </button>
        </div>
      </div>
      <div class="content pause">
        <h3> 游戏暂停 </h3>
        <div class="btn-wrap">
          <button class="btn btn-resume"> 继续游戏 </button>
        </div>
      </div>
    </div>
  </div>

</div> 
<script src="http://cpro.baidustatic.com/cpro/ui/cm.js" type="text/javascript"></script>

</body>
</html>
<script src="assets/js/libs.min.js?a=1111"></script>
<script src="assets/js/main.min.js?ver=1.11.41"></script>

