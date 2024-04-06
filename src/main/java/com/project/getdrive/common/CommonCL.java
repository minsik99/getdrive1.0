package com.project.getdrive.common;

//월별 스케줄 기능 출력 객체
public class CommonCL {
	
	private int year;
	private int month;
	
	
	public CommonCL() {
		super();
	}


	public CommonCL(int year, int month) {
		super();
		this.year = year;
		this.month = month;
	}


	public int getYear() {
		return year;
	}


	public void setYear(int year) {
		this.year = year;
	}


	public int getMonth() {
		return month;
	}


	public void setMonth(int month) {
		this.month = month;
	}


	@Override
	public String toString() {
		return "CommonCL [year=" + year + ", month=" + month + "]";
	}
	
}
