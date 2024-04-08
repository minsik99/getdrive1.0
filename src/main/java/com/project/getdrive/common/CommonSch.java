package com.project.getdrive.common;

public class CommonSch {
	
	// 객체
	private String keyword; // 키워드
	private int startRow;	// 시작행
	private int endRow;		// 끝행
	
	// 생성자
	public CommonSch() {
		super();	
	}

	// getter & setter
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	// toString
	@Override
	public String toString() {
		return "Search [keyword=" + keyword + ", startRow=" + startRow + ", endRow=" + endRow + "]";
	}
}
