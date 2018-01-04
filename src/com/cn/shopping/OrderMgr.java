package com.cn.shopping;

import java.util.List;

import com.cn.shopping.dao.*;

public class OrderMgr {
	
	static OrderMgr om = null;
	
	static {
		if(om == null) {
			om = new OrderMgr();
			om.setDao(new OrderMySQLDAO());
		}
	}
	private OrderMgr() {};
	
	public static OrderMgr getInstanct() {
		return om;
	}
	
	OrderDAO dao = null;

	
	public OrderDAO getDao() {
		return dao;
	}

	public void setDao(OrderDAO dao) {
		this.dao = dao;
	}
	
	public void save(SalesOrder order) {
		dao.save(order);
	}
	
	public int getOrders(List<SalesOrder> orders , int pageNum, int pageSize) {
		return dao.getOrders(orders , pageNum , pageSize);
	}
	
	public SalesOrder loadById(int id) {
		return dao.loadById(id);
	}
	
	public List<SalesItem> getItem(SalesOrder so) {
		return dao.getItem(so);
	}
	
	public boolean updateSalesOrder(int id, String status) {
		return dao.updateSalesOrder(id, status);
	}
}
