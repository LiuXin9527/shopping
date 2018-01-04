package com.cn.shopping.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.cn.shopping.Category;
import com.cn.shopping.Product;
import com.cn.shopping.util.DB;

public class ProductMySQLDAO implements ProductDAO{

	public List<Product> getProducts() {
		Connection conn = null;
		ResultSet rs = null;
		conn = DB.getConn();
		String sql ="select * from  product";
		rs = DB.executeQuery(conn, sql);
		List<Product> list = new ArrayList<Product>();
		try {
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getInt("price"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				list.add(p);
				
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
	
	
	
	public List<Product> getProducts(int pageNum, int pageSize) {
		Connection conn = null;
		ResultSet rs = null;
		conn = DB.getConn();
		String sql ="select * from  product limit "+(pageNum-1)*pageSize + "," + pageSize;
		rs = DB.executeQuery(conn, sql);
		List<Product> list = new ArrayList<Product>();
		try {
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getInt("price"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				list.add(p);
				
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
	

	
	public int getProducts(List<Product>  products, int pageNum, int pageSize) {
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCount = null;
		int pageCount = 0;
		try {
			conn = DB.getConn();
			rsCount = DB.executeQuery(conn, "select count(*) from product");
			rsCount.next();
			pageCount = (rsCount.getInt(1) + pageSize-1)/pageSize; //13+2/3
			String sql =
					"select product.id, product.name, product.descr, product.price, product.pdate, product.categoryid,"+ 
					" category.id cid, category.pid cpid, category.name cname, category.descr cdescr, category.isleaf cisleaf, category.grade cgrade"+ 
					" from product join category on(category.id=product.categoryid)  limit "+(pageNum-1)*pageSize + "," + pageSize;
						
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getInt("price"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				Category c = new Category();
				c.setName(rs.getString("cname"));
				p.setC(c);
				products.add(p);
			}
			System.out.println(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return pageCount;
	}
	
	public List<Product> findProducts(int[] categoryId, 
									  String keyWord,
									  double lowNormalPrice,
									  double hightNormalPrice,
									  Date startDate,
									  Date endDate,
									  int pageNum,
									  int pageSize) {
		Connection conn = null;
		ResultSet rs = null;
		List<Product> list = new ArrayList<Product>();
		try {
			conn = DB.getConn();
			String sql = "select product.id, product.name, product.descr, product.price, product.pdate, product.categoryid,"+
							" category.id cid, category.pid cpid, category.name cname, category.descr cdescr, category.isleaf cisleaf, category.grade cgrade"+
					 " from product join category on(category.id=product.categoryid) where 1=1 ";
			String strId = "";
			if(categoryId != null && categoryId.length >0) {
				strId += "(";
				for(int i=0; i<categoryId.length; i++) {
					if(0 < (categoryId.length - i)-1) {  // 0<3-0
						strId += categoryId[i]+",";
					}else {
						strId += categoryId[i];
					}
				}
				strId += ")";
				sql += " and categoryid in " + strId;
			}
			
			if(keyWord != null && !keyWord.trim().equals("")) {
				sql += " and product.name like '%" + keyWord + "%' or product.descr like '%" + keyWord + "%'";
			}
			
			if(lowNormalPrice >= 0) {  //  10   1~8  
				sql += " and price >= " + lowNormalPrice;
			}
			
			if(hightNormalPrice > 0) {
				sql += " and price <= " + hightNormalPrice;
			}
			
			
			if(startDate != null) {
				sql += " and date_format(pdate,'%Y-%m-%d') >= " + "'" + new SimpleDateFormat("yyyy-MM-dd").format(startDate) + "'";
			}
			
			if(endDate != null) { // 27 27
				sql += " and date_format(pdate,'%Y-%m-%d') <= " + "'" + new SimpleDateFormat("yyyy-MM-dd").format(endDate) + "'";
			}
			
			System.out.println(sql);
			//String sql ="select * from  product limit "+(pageNum-1)*pageSize + "," + pageSize;
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getInt("price"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				Category c = new Category();
				c.setName(rs.getString("cname"));
				p.setC(c);
				list.add(p);
				
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
	
	public List<Product> findIndexProducts(String keyWord){
		
		Connection conn = null;
		ResultSet rs = null;
		List<Product> list = new ArrayList<Product>();
		try {
			conn = DB.getConn();
			String sql = "select product.id, product.name, product.descr, product.price, product.pdate, product.categoryid,"+
					" category.id cid, category.pid cpid, category.name cname, category.descr cdescr, category.isleaf cisleaf, category.grade cgrade"+
			 " from product join category on(category.id=product.categoryid) where 1=1 ";

			if(keyWord != null && !keyWord.trim().equals("")) {
				sql += " and product.name like '%" + keyWord + "%' or product.descr like '%" + keyWord + "%'";
		}
		System.out.println(sql);
		rs = DB.executeQuery(conn, sql);
		while(rs.next()) {
			Product p = new Product();
			p.setId(rs.getInt("id"));
			p.setName(rs.getString("name"));
			p.setDescr(rs.getString("descr"));
			p.setNormalPrice(rs.getInt("price"));
			p.setPdate(rs.getTimestamp("pdate"));
			p.setCategoryId(rs.getInt("categoryid"));
			
			Category c = new Category();
			c.setName(rs.getString("cname"));
			p.setC(c);
			list.add(p);
		
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
	
	
	public boolean deleteProductByCategoryId(int categoryId) {
		Connection conn = null;
		Statement stmt = null;
		try {
		conn = DB.getConn();
		stmt= DB.getStmt(conn);
		String sql ="delete  from  product where id = "+ categoryId;
		 stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally {
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
		
		return true;
		
	}
	public boolean deleteProductById(int[] idArray) {
		return false;
		
	}
	
	public boolean updatePriduct(Product p) {
		return false;
	}

	public boolean addProduct(Product p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "insert into product values (null , ? , ? , ? , ? , ?)" ;
			
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setTimestamp(4, p.getPdate());
			pstmt.setInt(5, p.getCategoryId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		finally {
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}
		return true;
	}
	
	public Product loadById(int id) {
		Product p = null;
		Connection conn = null;
		ResultSet rs = null;
		Category c = null;
		conn = DB.getConn();
		String sql = "select product.id, product.name, product.descr, product.price, product.pdate, product.categoryid,"+
				" category.id cid, category.pid cpid, category.name cname, category.descr cdescr, category.isleaf cisleaf, category.grade cgrade"+
		 " from product join category on(category.id=product.categoryid) where product.id = " + id;
		rs = DB.executeQuery(conn, sql);
		try {
			while(rs.next()) {
				p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getInt("price"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				c = new Category();
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				p.setC(c);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return p;
	}
	
	public boolean updateProduct (Product p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		conn = DB.getConn();
		try {
			String sql = "update  product set name = ? , descr = ? , price = ?  , categoryid = ? "+" where id = "+ p.getId() ;
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setInt(4, p.getCategoryId());
			pstmt.executeUpdate();
			System.out.println(sql);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		finally {
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}
		return true;
	}
	
	public List<Product> getLatestProducts(int count) {
		Connection conn = null;
		ResultSet rs = null;
		conn = DB.getConn();
		String sql ="select * from  product ORDER BY pdate DESC LIMIT 0, " + count;
		rs = DB.executeQuery(conn, sql);
		List<Product> list = new ArrayList<Product>();
		try {
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getInt("price"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				list.add(p);
				
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