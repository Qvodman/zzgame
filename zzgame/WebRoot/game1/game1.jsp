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
	
	int game1_score=0;//第1关得分传给此变量

	//向数据库传入得分
	sql = "update user set game1_score=? where username=?";
	PreparedStatement stmt = dbConn.prepareStatement(sql);
	stmt.setInt(1,game1_score);
	stmt.setString(2,user.getUsername());
	stmt.executeUpdate();	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>游戏一</title>
<link rel="stylesheet" href="assets/css/m.css">
<style>

*{
  margin:0;
  padding:0;
  list-style-type:none;
}

a,img{
  border:0;
}
body{
  font:12px/180% Arial, 
  Helvetica,
  sans-serif, 
  "新宋体";
}

</style>
</head>
<body>

<div class="grid">
  <div class="page hide" id="loading"> loading... </div>
  <div class="page hide" id="index">
    <h1>游戏一</h1>
    <div id="help">点击移动的地鼠</div>
    <div class="btns">
      <button data-type="color" class="btn play-btn"> 开始游戏 </button>
    </div>
  </div>
  <div class="page hide" id="room">
    <div class="sum">规定分数：50</div>
    <header> 
      <span> 得分： <em id="lv"> 0 </em> </span> <span class="time"> 
      </span> <span class="btn btn-pause"> 暂停 </span> 
    </header>
    <div class="main" id="main" >
		<div class="container" id="container">
	</div>
	</div>
  </div>
  <div class="page hide" id="dialog">
    <div class="inner">
      <div class="content gameover">
        <h3></h3>
        <div class="btn-wrap">
          <button class="btn btn-restart"> 再来一次 </button>
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