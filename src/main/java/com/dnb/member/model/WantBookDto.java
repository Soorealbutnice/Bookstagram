package com.dnb.member.model;

public class WantBookDto extends MemberDto {
	
	private int wbook_no;
	private String wisbn;
	private String wbook_title;
	private String wbook_pic;
	private String wbook_desc;
	private String wgenre;
	private int price;
	private String wbook_author;
	
	public int getWbook_no() {
		return wbook_no;
	}
	public void setWbook_no(int wbook_no) {
		this.wbook_no = wbook_no;
	}
	public String getWisbn() {
		return wisbn;
	}
	public void setWisbn(String wisbn) {
		this.wisbn = wisbn;
	}
	public String getWbook_title() {
		return wbook_title;
	}
	public void setWbook_title(String wbook_title) {
		this.wbook_title = wbook_title;
	}
	public String getWbook_pic() {
		return wbook_pic;
	}
	public void setWbook_pic(String wbook_pic) {
		this.wbook_pic = wbook_pic;
	}
	public String getWbook_desc() {
		return wbook_desc;
	}
	public void setWbook_desc(String wbook_desc) {
		this.wbook_desc = wbook_desc;
	}
	public String getWgenre() {
		return wgenre;
	}
	public void setWgenre(String wgenre) {
		this.wgenre = wgenre;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getWbook_author() {
		return wbook_author;
	}
	public void setWbook_author(String wbook_author) {
		this.wbook_author = wbook_author;
	}
	
	
	
}
