package com.cn.shopping.dao;

import java.util.Date;
import java.util.List;

import com.cn.shopping.Product;

public class ParoductOracleDAO implements ProductDAO {

	
	public List<Product> getProducts() {
		
		return null;
	}

	
	public List<Product> getProducts(int pageNum, int pageSize) {
		
		return null;
	}

	
	public List<Product> findProducts(int[] categoryId, String name, String descr, double lowNormalPrice,
			double hightNormalPrice, double lowMemberPrice, double hightMemberPrice, Date startDate, Date endDate) {
		
		return null;
	}

	
	public boolean deleteProductByCategoryId(int categoryId) {
		
		return false;
	}

	
	public boolean deleteProductById(int[] idArray) {
		
		return false;
	}

	
	public boolean updateProduct(Product p) {
		
		return false;
	}


	public boolean addProduct(Product p) {
		return false;
	}


	@Override
	public List<Product> findProducts(int[] categoryId, String keyWord, double lowNormalPrice, double hightNormalPrice,
			Date startDate, Date endDate, int pageNum, int pageSize) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public int getProducts(List<Product> products, int pageNum, int pageSize) {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public Product loadById(int id) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public List<Product> getLatestProducts(int id) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public List<Product> findIndexProducts(String keyWord) {
		// TODO Auto-generated method stub
		return null;
	}

}
