package DB;

import java.sql.*;
public class DB {
	private String dbUrl = "jdbc:mysql://localhost:3306/zzgame?useUnicode=true&characterEncoding=utf-8";
	private String dbUser = "root";
	private String dbPwd = "123456";
	
	public DB () throws Exception{
	     Class.forName("com.mysql.jdbc.Driver");
	  }
	
	public Connection getConnection()throws Exception{
		return java.sql.DriverManager.getConnection(dbUrl,dbUser,dbPwd);
	}
	
	public void closeConnection(Connection con){
	    try{
	        if(con!=null) con.close();
	      }catch(Exception e){
	        e.printStackTrace();
	      }
	}
	
	public void closePrepStmt(PreparedStatement prepStmt){
	    try{
	        if(prepStmt!=null) prepStmt.close();
	      }catch(Exception e){
	        e.printStackTrace();
	      }
	  }

	public void closeResultSet(ResultSet rs){
	    try{
	        if(rs!=null) {
	        	rs.close();
	        	}
	      }catch(Exception e){
	        e.printStackTrace();
	      }
	  }

}
