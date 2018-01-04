package com.cn.shopping;

import java.sql.*;

public class SalesOrder {
	int id;
	User user;
	String addr;
	Timestamp oDate;
	String phone;
	int delivery;
	int status;
	
	Cart cart;
	static Cart singleCart;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User u) {
		this.user = u;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public Timestamp getoDate() {
		return oDate;
	}

	public void setoDate(Timestamp oDate) {
		this.oDate = oDate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Cart getCart() {
		return cart;
	}

	public void setCart(Cart c) {
		this.cart = c;
	}
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getDelivery() {
		return delivery;
	}

	public void setDelivery(int delivery) {
		this.delivery = delivery;
	}
	
	public static  void setsingleCart(Cart singleCart) {
		SalesOrder.singleCart = singleCart;
	}
	
	public static  Cart getsingleCart() {
		return singleCart;
	}
}
