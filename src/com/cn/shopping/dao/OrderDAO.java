package com.cn.shopping.dao;
import java.util.List;

import com.cn.shopping.*;
public interface OrderDAO {
	public void save(SalesOrder order);
	public int getOrders(List<SalesOrder> orders , int pageNum, int pageSize);
	public SalesOrder loadById(int id);
	public List<SalesItem> getItem(SalesOrder so);
	public boolean updateSalesOrder(int id, String status);
}
