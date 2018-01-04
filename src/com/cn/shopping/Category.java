package com.cn.shopping;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cn.shopping.util.DB;

public class Category {
	//實體類
	int id ;
	int pid;
	String name;
	String descr;
	boolean leaf;
	int grade;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	public static void save(Category c) {
		CategoryDAO.save(c);
	}
	
	public  void addChild(Category c) {
		addChildCategory(id , c.getName() , c.getDescr());
	}
	
	public static void addTopCategory(String name , String descr) {
		Category c = new Category();
		c.setId(-1);
		c.setName(name);
		c.setDescr(descr);
		c.setPid(0); //根上 根目錄
		c.setLeaf(true); //是否有枝葉
		c.setGrade(1);  //級別 最根上
		save(c);
	}
	
	public static void addChildCategory(int pid , String name , String descr) {
		
		CategoryDAO.saveChild(pid , name , descr);
	}
	
	
	public static List<Category> getCategories(){
		List<Category> list = new ArrayList<Category>();
		CategoryDAO.getCategories(list , 0);
		
		return list;
		
	}
	
	public static List<Category> getProductCategories(){
		List<Category> list = new ArrayList<Category>();
		CategoryDAO.getProductCategories(list , 0);
		
		return list;
		
	}
	
	public static String deleteCategory(int id , int pid){
		return CategoryDAO.deleteCategory(id , pid);
	}
	public static Category loadById(int id) {
		return CategoryDAO.loadById(id);
	}
	
	public static String getCategoriesTree(List<Category> list) {
		String str="";
		str = CategoryDAO.getCategoriesTree(list , str);
		return str;
	}
	
	public static List<Integer> findCategoriesOfSon(int categoryId) {
		List<Integer> list = new ArrayList<Integer>();
		list.add(categoryId);
		CategoryDAO.findCategoriesOfSon(list, categoryId);
		return list;
	}
}
