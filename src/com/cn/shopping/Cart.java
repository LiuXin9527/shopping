package com.cn.shopping;


import java.util.*;
import com.cn.shopping.*;

public class Cart {
	List<CartItem> items = new ArrayList<CartItem>();

	public List<CartItem> getItems() {
		return items;
	}

	public void setItems(List<CartItem> items) {
		this.items = items;
	}
	
	public void add(CartItem item) {
		for(int i=0;i<items.size(); i++) {
			CartItem ci = items.get(i);
			if(item.getId() == ci.getId()) {
				ci.setCount(ci.getCount() + item.getCount());
				return;
			}
		}
		items.add(item);
		
	}
	
	public void delete(int id) {
		for(int i=0;i<items.size(); i++) {
			CartItem ci = items.get(i);
			if(ci.getId() == id) {
				items.remove(i);
				i--;
				return;
			}
		}
	}
	
	public double totalPrice() {
		double total = 0;
		for(int i=0;i<items.size(); i++) {
			CartItem ci = items.get(i);
			total+=ci.getPrice()*ci.getCount();
		}
		return total;
		
		
	}
	
}
