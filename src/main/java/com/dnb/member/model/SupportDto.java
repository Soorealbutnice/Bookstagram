package com.dnb.member.model;

public class SupportDto extends MemberDto {

	private int support_no;
	private int pay;
	private String supporter;
	private String support_date;
	private String supported_id;
	
	public int getSupport_no() {
		return support_no;
	}
	public void setSupport_no(int support_no) {
		this.support_no = support_no;
	}
	public int getPay() {
		return pay;
	}
	public void setPay(int pay) {
		this.pay = pay;
	}
	public String getSupporter() {
		return supporter;
	}
	public void setSupporter(String supporter) {
		this.supporter = supporter;
	}
	public String getSupport_date() {
		return support_date;
	}
	public void setSupport_date(String support_date) {
		this.support_date = support_date;
	}
	public String getSupported_id() {
		return supported_id;
	}
	public void setSupported_id(String supported_id) {
		this.supported_id = supported_id;
	}
	
	
}
