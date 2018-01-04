package com.cn.shopping;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.cn.shopping.util.DB;

public class User {
	
	private int id;

	private String username;

	private String password;

	private String phone;



	private Timestamp rdate;


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Timestamp getRdate() {
		return rdate;
	}

	public void setRdate(Timestamp rdate) {
		this.rdate = rdate;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
		
		
	public void save() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "insert into user values (null , ? , ? , ? , ?)" ;
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, phone);
			pstmt.setTimestamp(4, rdate);
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}
	}

	public static List<User> getUsers(){
		List<User> list = new ArrayList<User>();
		Connection conn = null;
		ResultSet rs = null;
		
		conn = DB.getConn();
		String sql ="select * from  user";
		rs = DB.executeQuery(conn, sql);
		
		try {
			while(rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setRdate(rs.getTimestamp("rdate"));
				list.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return list;
	}
	
	public static void deleteUser(int id) {
		Connection conn = null;
		Statement stmt = null;
		try {
		conn = DB.getConn();
		stmt= DB.getStmt(conn);
		String sql ="delete  from  user where id = "+ id;
		 stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
		
	}
	
	public static boolean usernameExist(String username) {
		return false;
	}
	
	public static boolean passwordCorrect(String username , String password) {
		return false;
	}
	
	public static User vaildate(String username , String password) throws UserNotFoundException, PasswordNotCorrectException {
		Connection conn = null;
		ResultSet rs = null;
		User u = null;
		conn = DB.getConn();
		String sql ="select * from  user where username = '" + username + "'";
		rs = DB.executeQuery(conn, sql);
		
		try {
			if(!rs.next()) {
				throw new UserNotFoundException();
			}else if(!rs.getString("password").equals(password)) {
				throw new PasswordNotCorrectException();
			}else {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setRdate(rs.getTimestamp("rdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
			return u;
	}
	
	public void update() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		conn = DB.getConn();
		try {
			String sql = "update  user set password = ? , phone = ? "+" where id = "+ this.id ;
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, password);
			pstmt.setString(2, phone);
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}
	}
		
}
