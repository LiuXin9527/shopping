package com.cn.shopping;
public class UserNotFoundException extends Exception {
	public static void main(String[] args) {
		//printStars(200);
	}
	static int temp=1;
	public static void printStars(int num) {
		int count = 0;
		int judNum = 0;
		if(num%2==1) { //檢查是偶數或奇數
			if(num==2 || num==3) {
				count = num;
			}else {
			num--;
			count = num/2;
			}
		}else {
			num-=2;
			count = num/2;  //8 11
		}
		
		judNum = judgementNum(count); //判斷count 可以循環幾次
		printSpace(judNum , sum);  //印出星星
	}
	static int sum = 0;				
	public static int judgementNum(int num) {//假如傳進 8 11
		int temp = 0;
		int count = 0;
		for(int x = 3; x<=num; x+=2) {
			if(!((temp+x)>num)) {  
				temp+=x;  
				count++;  
				sum =x;
			}else {
				return count;
			}
		}
		return  0;
	}
	public static void printSpace(int judNum , int total) { 
		int temp = judNum;
		for(int x=1; x<=judNum;x++) {
			for(int i=1;i<=total;i++ ) {
				System.out.print("*");
			}
			total-=2;
			System.out.println();
			for(int i=judNum-1; i<temp;i++) {
				System.out.print(" ");
			}
			temp++;
		}
		System.out.println("*");
		 temp = judNum;
		for(int x=1; x<=judNum;x++) {
			for(int i=1; i<temp;i++) {
				System.out.print(" ");
			}
			temp--;
			total+=2;
			
			for(int i=1;i<=total;i++ ) {
				System.out.print("*");
			}
			System.out.println();
		}
	}
}