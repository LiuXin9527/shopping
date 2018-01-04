package com.cn.shopping;

import java.util.Date;
import java.util.List;

import com.cn.shopping.dao.*;

//單一工廠模式 用於只會有一個管理員 無須多個管理員
public class ProductMgr {
	
	static ProductMgr pm = null;
	
	static {
		if(pm == null) {
			pm = new ProductMgr();
			pm.setDao(new ProductMySQLDAO());
		}
	}
	private ProductMgr() {};
	
	public static ProductMgr getInstanct() {
		return pm;
	}
	
	ProductDAO dao = null;

	public List<Product> getProducts() {
		return dao.getProducts();
	}
	
	public List<Product> getProducts(int pageNum, int pageSize) {
		return dao.getProducts(pageNum ,pageSize );
	}
	
	public int getProducts(List<Product>  products , int pageNum, int pageSize) {
		return dao.getProducts(products, pageNum ,pageSize );
	}
	
	public List<Product> findProducts(int[] categoryId, 
									  String keyWord,
									  double lowNormalPrice,
									  double hightNormalPrice,
									  Date startDate,
									  Date endDate,
									  int pageNum,
									  int pageSize) {
		return dao.findProducts(categoryId, keyWord, lowNormalPrice, hightNormalPrice,  startDate, endDate, pageNum, pageSize);
				  
	}
	
	public List<Product> findIndexProducts(String keyWord){
		return dao.findIndexProducts(keyWord);
}
	
	public List<Product> findProducts(String name){
		return null;
	}
	
	public boolean deleteProductByCategoryId(int categoryId) {
		return dao.deleteProductByCategoryId(categoryId);
		
	}
	public boolean deleteProductById(int[] idArray) {
		return false;
		
	}
	
	public boolean updateProduct(Product p) {
		return dao.updateProduct(p);
	}
	
	public ProductDAO getDao() {
		return dao;
	}

	public void setDao(ProductDAO dao) {
		this.dao = dao;
	}
	
	public boolean addProduct(Product p) {
		return dao.addProduct(p);
	}
	public Product loadById(int id) {
		return dao.loadById(id);
	}
	
	public List<Product> getLatestProducts(int count) {
		return dao.getLatestProducts(count);
	}
	
}
