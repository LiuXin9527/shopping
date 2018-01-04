package com.cn.shopping;

public class PasswordNotCorrectException extends Exception {

	public static void main(String[] args){
		int x=31;
		int y=(x-1)/2;
		int z=3;
		int l=1;
		int xx=0;
		for(int i=z; i<y; i=i+z){  //i=3 3<15 3+3
			if((i+z+2)<=y){ //3+3+2<=15
				z=z+2;
			}
		}
		for(int m=z; m>=3; m=m-2){
			x=x-(m*2);	
		}
		xx=x-1;
		for(int m=z; m>=3;m=m-2){
			for(int j=1; j<=m; j++){
				System.out.print("*");
			}
			System.out.println("  ");
			for(int i=1; i<=l ;i++){
			System.out.print(" ");
			}
			l=l+1;
		}
		System.out.println("*");
			l=l-1;
		for(int i=3; i<=z;i=i+2){
			l=l-1;
			for(int m=l; m>=1 ;m--){
				System.out.print(" ");
				}
			for(int j=1; j<=i; j++){
				System.out.print("*");
			}
			System.out.println("  ");
		}
		System.out.println(xx);
	
}
}
