package com.dnb.member.model;

public class FollowDto extends MemberDto {
	
	private int follow_no;
	private String follower_id;
	private String follow_date;
	private String followed_id;
	
	public int getFollow_no() {
		return follow_no;
	}
	public void setFollow_no(int follow_no) {
		this.follow_no = follow_no;
	}
	public String getFollower_id() {
		return follower_id;
	}
	public void setFollower_id(String follower_id) {
		this.follower_id = follower_id;
	}
	public String getFollow_date() {
		return follow_date;
	}
	public void setFollow_date(String follow_date) {
		this.follow_date = follow_date;
	}
	public String getFollowed_id() {
		return followed_id;
	}
	public void setFollowed_id(String followed_id) {
		this.followed_id = followed_id;
	}
	


}
