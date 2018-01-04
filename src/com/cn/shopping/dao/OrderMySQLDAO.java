package com.cn.shopping.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.cn.shopping.*;
import com.cn.shopping.util.DB;

public class OrderMySQLDAO implements OrderDAO {

	@Override
	public void save(SalesOrder so) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rsKey = null;
		conn = DB.getConn();
		try {
			conn.setAutoCommit(false);
			String sql = "insert into salesorder01 values (null , ? , ? , ? , ? , ?, ?)" ;
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setInt(1, so.getUser().getId());
			pstmt.setString(2, so.getAddr());
			pstmt.setTimestamp(3, so.getoDate());
			pstmt.setString(4, so.getPhone());
			pstmt.setInt(5, so.getDelivery());
			pstmt.setInt(6, so.getStatus());
			pstmt.executeUpdate();
			
			rsKey = pstmt.getGeneratedKeys();
			rsKey.next();
			int key = rsKey.getInt(1);
			pstmt.close();
			
			String sqlItem = "insert into salesitem values (null , ? , ? , ? , ?)" ;
			pstmt = DB.getPStmt(conn, sqlItem);
			List<CartItem> items = so.getCart().getItems();
			for(int i=0; i<items.size(); i++) {
				CartItem ci = items.get(i);
				pstmt.setInt(1, ci.getId());
				pstmt.setDouble(2, ci.getPrice());
				pstmt.setInt(3, ci.getCount());
				pstmt.setInt(4, key);
				System.out.println(items.size()+"  "+ci.getId() +" "+ key);
				pstmt.addBatch();
			}
			pstmt.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				conn.setAutoCommit(true);
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		finally {
			DB.closeRs(rsKey);
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}
		
	}

	@Override
	public int getOrders(List<SalesOrder> orders , int pageNum, int pageSize) {
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
					"select salesorder01.id, salesorder01.userid, salesorder01.addr, salesorder01.odate, salesorder01.phone, salesorder01.delivery, salesorder01.status,"+ 
					" user.id uid, user.username uname "+ 
					" from salesorder01 join user on(salesorder01.userid=user.id)  limit "+(pageNum-1)*pageSize + "," + pageSize;
						
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				User u = new User();
				u.setId(rs.getInt("uid"));
				u.setUsername(rs.getString("uname"));
				
				SalesOrder so = new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setoDate(rs.getTimestamp("odate"));
				so.setPhone(rs.getString("phone"));
				so.setDelivery(rs.getInt("delivery"));
				so.setStatus(rs.getInt("status"));
				so.setUser(u);
				orders.add(so);
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

	@Override
	public SalesOrder loadById(int id) {
		SalesOrder so = new SalesOrder();
		Connection conn = null;
		ResultSet rs = null;
		conn = DB.getConn();
		String sql = "select salesorder01.id, salesorder01.userid, salesorder01.addr, salesorder01.odate, salesorder01.phone, salesorder01.delivery, salesorder01.status,"+ 
				" user.id uid, user.username uname "+ 
				" from salesorder01 join user on(salesorder01.userid=user.id) where salesorder01.id = " + id;
		rs = DB.executeQuery(conn, sql);
		try {
			if(rs.next()) {
				User u = new User();
				u.setId(rs.getInt("uid"));
				u.setUsername(rs.getString("uname"));
				
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setoDate(rs.getTimestamp("odate"));
				so.setPhone(rs.getString("phone"));
				so.setDelivery(rs.getInt("delivery"));
				so.setStatus(rs.getInt("status"));
				so.setUser(u);

				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return so;
	}

	@Override
	public List<SalesItem> getItem(SalesOrder so) {
		List<SalesItem> items = new ArrayList<SalesItem>();
		Connection conn = null;
		ResultSet rs = null;
		conn = DB.getConn();
		String sql = "select salesitem.id, salesitem.productid, salesitem.unitprice, salesitem.pcount, salesitem.orderid, " +
				"product.id pid, product.name pname, product.descr pdescr "+ 
				"from salesitem join product on(salesitem.productid = product.id) where orderid ="+ so.getId();
		rs = DB.executeQuery(conn, sql);
		try {
			while(rs.next()) {
				SalesItem si = new SalesItem();
				si.setId(rs.getInt("id"));
				si.setCount(rs.getInt("pcount"));
				si.setPrice(rs.getDouble("unitprice"));
				
				Product p = new Product();
				p.setId(rs.getInt("pid"));
				p.setNormalPrice(rs.getDouble("unitprice"));
				p.setName(rs.getString("pname"));
				p.setDescr(rs.getString("pdescr"));
				
				si.setSo(so);
				si.setProduct(p);
				items.add(si);
			}
			System.out.println(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return items;
	}
	
	public boolean updateSalesOrder (int id, String status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		conn = DB.getConn();
		try {
			String sql = "update  salesorder01 set status = ?  where id = "+ id ;
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, status);
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


}
