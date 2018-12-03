package com.dnb.member.model;

public class ReadBookDto extends MemberDto {
	
	private int rbook_no;
	private String risbn;
	private String rbook_title;
	private String rbook_desc;
	private String rbook_author;
	private String read_date;
	private String rbook_pic;
	
	public int getRbook_no() {
		return rbook_no;
	}
	public void setRbook_no(int rbook_no) {
		this.rbook_no = rbook_no;
	}
	public String getRisbn() {
		return risbn;
	}
	public void setRisbn(String risbn) {
		this.risbn = risbn;
	}
	public String getRbook_title() {
		return rbook_title;
	}
	public void setRbook_title(String rbook_title) {
		this.rbook_title = rbook_title;
	}
	public String getRbook_desc() {
		return rbook_desc;
	}
	public void setRbook_desc(String rbook_desc) {
		this.rbook_desc = rbook_desc;
	}
	public String getRbook_author() {
		return rbook_author;
	}
	public void setRbook_author(String rbook_author) {
		this.rbook_author = rbook_author;
	}
	public String getRead_date() {
		return read_date;
	}
	public void setRead_date(String read_date) {
		this.read_date = read_date;
	}
	public String getRbook_pic() {
		return rbook_pic;
	}
	public void setRbook_pic(String rbook_pic) {
		this.rbook_pic = rbook_pic;
	}
	

}
