package com.cn.shopping;

public class SalesItem {
	int id;
	Product product;
	double price;
	int count ;
	SalesOrder so ;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product p) {
		this.product = p;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public SalesOrder getSo() {
		return so;
	}
	public void setSo(SalesOrder so) {
		this.so = so;
	}
	
	
	
	
}
