package com.dnb.post.model;

import com.dnb.member.model.MemberDto;

public class PostDto extends MemberDto{

	private int post_no;
	private String title;
	private String content;
	private String book_name;
	private String origin_postPicture;
	private String save_postPicture;
	private String psavefolder;
	private String simpleReview;
	private int like_count;
	private String write_date;
	private String post_id;
	private String hashtag1;
	private String hashtag2;
	private String hashtag3;
	private String hashtag4;
	private String bookImg;
	private String bookInfo;
	private String isbn;
	private String search;
	
	public int getPost_no() {
		return post_no;
	}
	public void setPost_no(int post_no) {
		this.post_no = post_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getOrigin_postPicture() {
		return origin_postPicture;
	}
	public void setOrigin_postPicture(String origin_postPicture) {
		this.origin_postPicture = origin_postPicture;
	}
	public String getSave_postPicture() {
		return save_postPicture;
	}
	public void setSave_postPicture(String save_postPicture) {
		this.save_postPicture = save_postPicture;
	}
	public String getPsavefolder() {
		return psavefolder;
	}
	public void setPsavefolder(String psavefolder) {
		this.psavefolder = psavefolder;
	}
	public String getSimpleReview() {
		return simpleReview;
	}
	public void setSimpleReview(String simpleReview) {
		this.simpleReview = simpleReview;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getPost_id() {
		return post_id;
	}
	public void setPost_id(String post_id) {
		this.post_id = post_id;
	}
	public String getHashtag1() {
		return hashtag1;
	}
	public void setHashtag1(String hashtag1) {
		this.hashtag1 = hashtag1;
	}
	public String getHashtag2() {
		return hashtag2;
	}
	public void setHashtag2(String hashtag2) {
		this.hashtag2 = hashtag2;
	}
	public String getHashtag3() {
		return hashtag3;
	}
	public void setHashtag3(String hashtag3) {
		this.hashtag3 = hashtag3;
	}
	public String getHashtag4() {
		return hashtag4;
	}
	public void setHashtag4(String hashtag4) {
		this.hashtag4 = hashtag4;
	}
	public String getBookImg() {
		return bookImg;
	}
	public void setBookImg(String bookImg) {
		this.bookImg = bookImg;
	}
	public String getBookInfo() {
		return bookInfo;
	}
	public void setBookInfo(String bookInfo) {
		this.bookInfo = bookInfo;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}


}
