package DAO;

public class user {
	private String username = null;
	private String password = null;
	private String nickname = null;
	private int score;
	public String getUsername(){
		return username;
    }
	public String getPassword(){
		return password;
    }
	public String getNickname(){
		return nickname;
    }
	public int getScore(){
		return score;
    }
	
	public void setUsername(String username){
   	 	this.username = username;
    }
	public void setPassword(String password){
   	 	this.password = password;
    }
	public void setNickname(String nickname){
   	 	this.nickname = nickname;
    }
	public void setScore(int score){
		this.score = score;
    }

}
