package com.cn.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import com.cn.shopping.util.*;

public class CategoryDAO {
	
	//和數據庫打交道
	public static void save(Category c) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql;
			if(c.getId() == -1) {
				sql = "insert into category values (null , ? , ? , ? , ? , ?)" ;
			}else {
				sql = "insert into category values ("+ c.getId() +" , ? , ? , ? , ? , ?)" ;
			}
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setInt(1, c.getPid());
			pstmt.setString(2, c.getName());
			pstmt.setString(3, c.getDescr());
			pstmt.setInt(4, c.isLeaf() ? 0 : 1);
			pstmt.setInt(5, c.getGrade());
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
	
	public static void saveChild( int pid , String name , String descr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			rs = DB.executeQuery(conn, "select * from category where id ="+pid);
			rs.next();
			int parentGrade = rs.getInt("grade");
			String sql = "insert into category values (null , ? , ? , ? , ? , ?)" ;
			
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setInt(1, pid);
			pstmt.setString(2, name);
			pstmt.setString(3, descr);
			pstmt.setInt(4, 0);
			pstmt.setInt(5, parentGrade+1);
			pstmt.executeUpdate();
			DB.executeUpdate(conn, "update category set isleaf=1 where id="+ pid);
			
			conn.commit();
			conn.setAutoCommit(true);
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		finally {
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}		
	}
	public static List<Category> getCategories(List<Category> list , int id){
		Connection conn = null;
		try {
				conn = DB.getConn();
				list = getCategories(conn , list , id);
			}
		
		finally {
			DB.closeConn(conn);
		}
		return list;
		
	}
	
	private static List<Category> getCategories(Connection conn, List<Category> list , int id){
		ResultSet rs = null;
		String sql ="select * from  category where pid =" + id;
		rs = DB.executeQuery(conn, sql);
		try {
			while(rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setPid(rs.getInt("pid"));
				c.setGrade(rs.getInt("grade"));
				c.setDescr(rs.getString("descr"));
				c.setLeaf(rs.getInt("isleaf") == 1 ? true : false);
				list.add(c);
				if(c.isLeaf()) {
					getCategories(list , c.getId());
				}
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
	//第二種判斷是否節點
	public static List<Category> getProductCategories(List<Category> list , int id){
		Connection conn = null;
		ResultSet rs = null;
		conn = DB.getConn();
		String sql ="select * from  category where pid =" + id;
		rs = DB.executeQuery(conn, sql);
		try {
			while(rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setPid(rs.getInt("pid"));
				c.setGrade(rs.getInt("grade"));
				c.setDescr(rs.getString("descr"));
				c.setLeaf(rs.getInt("isleaf") == 1 ? true : false);
				list.add(c);
				if(c.isLeaf()) {
					getProductCategories(list , c.getId());
				}else {
					
				}
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
	
	
	static boolean firstid = true;
	public static String deleteCategory(int id , int pid) {
		// TODO Auto-generated method stub
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		String deleteMsg ="刪除成功" ;
		conn = DB.getConn();
		stmt= DB.getStmt(conn);
		//判斷父類底下是否含子類
		List<Integer> list = new ArrayList<Integer>();
		list = findCategoriesOfSon(list, id);
		if(list.size() > 0) {
			deleteMsg = "父類至少有一個子類";
			return deleteMsg;
		}
		
		
		
		try {
			//找子類底下是否有產品
			sql = "select * from product where categoryid = " + id;
			rs = DB.executeQuery(conn, sql);
			list = new ArrayList<Integer>();
			while(rs.next()) {
				list.add(1);
			}
			if(list.size() > 0) {
				deleteMsg = "父類至少有一個產品";
				return deleteMsg;
			}
			rs.close();
			
			if(firstid) {
				sql ="select * from  category where id = "+ id;
				rs = DB.executeQuery(conn, sql);
			}
			else {
				sql ="select * from  category where pid = "+ id;
				rs = DB.executeQuery(conn, sql);
			}
			while(rs.next()) {
				if(firstid) {
					sql ="delete  from  category where id = "+ id;
					stmt.executeUpdate(sql);
					firstid = false;
				}
				else {
					sql ="delete  from  category where pid = "+ id;
					stmt.executeUpdate(sql);
				}
				if(rs.getInt("isleaf")==1) {
					System.out.println(id+" "+pid);
					deleteCategory(id , pid);
				}
			}	
			//以下判斷使否有節點 沒結點設isleaf=0
			DB.closeRs(rs);
			sql ="select * from  category where id = "+ pid;
			rs = DB.executeQuery(conn, sql);
			if(rs.next()) {
				sql ="select * from  category where pid = "+ pid;
				rs = DB.executeQuery(conn, sql);
				if(!rs.next()) {
				DB.executeUpdate(conn, "update category set isleaf=0 where id="+ pid);
				}
			}
			
			
		} 
		
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeStmt(stmt);
			DB.closeConn(conn);
			DB.closeRs(rs);
			firstid = true;
		}
		return deleteMsg;
	}

	public static Category loadById(int id) {
		Connection conn = null;
		ResultSet rs = null;
		Category c = null;
		conn = DB.getConn();
		String sql ="select * from  category where id =" + id;
		rs = DB.executeQuery(conn, sql);
		try {
			if(rs.next()) {
				c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setPid(rs.getInt("pid"));
				c.setGrade(rs.getInt("grade"));
				c.setDescr(rs.getString("descr"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return c;
	}
	
	static int ifid = 0;
	private static String getCategoriesTree(int id , String str) {
		Connection conn = null;
		ResultSet rs = null;
		conn = DB.getConn();
		String sql ="select * from  category where pid =" + id;
		rs = DB.executeQuery(conn, sql);
		
		try {
			while(rs.next()) {
				String name=rs.getString("name");
				boolean isleaf = rs.getInt("isleaf") == 1 ? true : false;
				 id = rs.getInt("id");
				 
				if(isleaf) {
					str+="<li id="+id+"><span>"+name+"</span><ul>";
					str = getCategoriesTree(id , str);
					str+="</ul></li>";
				}else {
					str+="<li id="+id+"><span>"+name+"</span></li>";
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return str;
	}
	static boolean firstcheck = true;
	public static String getCategoriesTree(List<Category> list , String str) {
		for(Iterator<Category> it = list.iterator() ; it.hasNext();){
			Category c = it.next();
			String name = c.getName();
			int grade = c.getGrade();
			int id = c.getId();
			int pid = c.getPid();
			boolean isleaf = c.isLeaf();
			
			if(firstcheck) {
				firstcheck = false;
				if(isleaf){
					ifid = id;
					str+="<li id="+0+"><span>類別總攬</span><ul><li id="+id+"><span name="+id+" onclick='getId()'"+">"+name+"</span><ul>";
					str = getCategoriesTree(id , str);
					str+="</ul></li>";
					continue;
				}else{
					str+="<li id="+0+"> 類別總攬 <ul><li id="+id+""+name+"</li>";
					continue;
				}
			}
			
			if(ifid == pid || grade>2) { // 74 125
				continue;
			}
			
			if(isleaf) {
				ifid = id;
				str+="<li id="+id+"><span>"+name+"</span><ul>";
				str = getCategoriesTree(id , str);
				str+="</ul></li>";
			}else {
				str+="<li id="+id+">"+name+"</li>";
			}
		}
		str+="</ul></li>";
		firstcheck = true;
		return str;
	}
	
	public static List<Integer> findCategoriesOfSon(List<Integer> list, int categoryId) {
		Connection conn = null;
		ResultSet rs = null;
		conn = DB.getConn();
		String sql ="select * from  category where pid =" + categoryId;
		rs = DB.executeQuery(conn, sql);
		try {
			while(rs.next()) {
				list.add(rs.getInt("id"));
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
	
}
