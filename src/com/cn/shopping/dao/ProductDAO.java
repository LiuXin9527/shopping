package com.cn.shopping.dao;

import java.util.Date;
import java.util.List;

import com.cn.shopping.Product;

public interface ProductDAO {

	public List<Product> getProducts();
	
	public List<Product> getProducts(int pageNum, int pageSize);
	
	public List<Product> findProducts(int[] categoryId, 
									  String keyWord,
									  double lowNormalPrice,
									  double hightNormalPrice,
									  Date startDate,
									  Date endDate,
									  int pageNum,
									  int pageSize);
	
	
	
	public boolean deleteProductByCategoryId(int categoryId);
	
	public boolean deleteProductById(int[] idArray);
	
	public boolean updateProduct(Product p);
	
	public boolean addProduct(Product p);

	public int getProducts(List<Product> products, int pageNum, int pageSize);

	public Product loadById(int id);

	public List<Product> getLatestProducts(int id);

	public List<Product> findIndexProducts(String keyWord);


}
