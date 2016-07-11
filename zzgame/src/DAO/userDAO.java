package DAO;
import java.sql.*;
import java.util.Vector;
import javax.servlet.http.*;
import DB.*;
public class userDAO {
	private String sql;
	private int i;
	private Connection dbConn;
	private user user = new user();
	DB dbc = null;


	public Vector getUser(){	
		sql = "select * from user";
		Vector userInfo = new Vector();
		try{
			dbc = new DB();
			dbConn = dbc.getConnection();
			Statement stmt = dbConn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				user user = new user();
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setNickname(rs.getString("nickname"));


				userInfo.add(user);
			}
		}catch(Exception e){
			System.err.println(e);
		}finally{
			try{
				dbc.closeConnection(dbConn);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return userInfo;
	}

	public user login(String username,String password){
		user user =null;
		try{
			dbc = new DB();
			dbConn = dbc.getConnection();
			sql = "select * from user where username=? and password=?";
			PreparedStatement stmt = dbConn.prepareStatement(sql);
			stmt.setString(1,username);
			stmt.setString(2,password);
			ResultSet rs = stmt.executeQuery();
			if (rs.next())
			{
				System.out.println ( "登录成功！" );
				user = new user();
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
			}
		}catch(Exception e){
			System.err.println(e);
		}finally{
			try{
				dbc.closeConnection(dbConn);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return user;
	}
		
	public user register(String username,String password,String nickname){
		user user =null;
		try{
			dbc = new DB();
			dbConn = dbc.getConnection();
			sql = "select * from user where username=? or nickname=?";
			PreparedStatement stmt = dbConn.prepareStatement(sql);
			stmt.setString(1,username);
			stmt.setString(2,nickname);
			ResultSet rs = stmt.executeQuery();
			if (rs.next())
			{
				System.out.println ( "用户已存在！" );
				user.setUsername(null);
				user.setPassword(null);
				user.setNickname(null);
			} else
			{
				sql = "insert into user(username,password,nickname,game1_score,game2_score,game3_score,game4_score,score)values(?,?,?,?,?,?,?,?)";
				stmt = dbConn.prepareStatement(sql);
				stmt.setString(1,username);
				stmt.setString(2,password);
				stmt.setString(3,nickname);
				stmt.setInt(4,0);
				stmt.setInt(5,0);
				stmt.setInt(6,0);
				stmt.setInt(7,0);
				stmt.setInt(8,0);
				stmt.executeUpdate();
				user = new user();
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				System.out.println ( "注册成功！" );
			}

		}catch(Exception e){
			System.err.println(e);
		}finally{
			try{
				dbc.closeConnection(dbConn);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return user;
	}
	
	
/*	public Vector ranking(){	
		sql = "SELECT * FROM user ORDER BY score DESC";
		Vector userInfo = new Vector();
		try{
			dbc = new DB();
			dbConn = dbc.getConnection();
			Statement stmt = dbConn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				user user = new user();
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setNickname(rs.getString("nickname"));
				userInfo.add(user);
				i++;
			}
		}catch(Exception e){
			System.err.println(e);
		}finally{
			try{
				dbc.closeConnection(dbConn);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return userInfo;
	}

	public int size(){
		return i;
	}

	public user elementAt(Vector order, int i) {
		return (user) order.elementAt(i);
	}*/
}


