package com.dnb.member.model;

public class BookinfoDto extends MemberDto {

   
   private String total;
   private String display;
   private String title;
   private String image;
   private String publisher;
   private String author;
   private String description;
   private String isbn;
   private String id;
   private String discount;
   private String price;
   private String pubdate;
   
   public String getDiscount() {
      return discount;
   }
   public void setDiscount(String discount) {
      this.discount = discount;
   }
   public String getPrice() {
      return price;
   }
   public void setPrice(String price) {
      this.price = price;
   }
   public String getPubdate() {
      return pubdate;
   }
   public void setPubdate(String pubdate) {
      this.pubdate = pubdate;
   }
   public String getTotal() {
      return total;
   }
   public void setTotal(String total) {
      this.total = total;
   }
   public String getDisplay() {
      return display;
   }
   public void setDisplay(String display) {
      this.display = display;
   }
   public String getTitle() {
      return title;
   }
   public void setTitle(String title) {
      this.title = title;
   }
   public String getImage() {
      return image;
   }
   public void setImage(String image) {
      this.image = image;
   }
   public String getPublisher() {
      return publisher;
   }
   public void setPublisher(String publisher) {
      this.publisher = publisher;
   }
   public String getAuthor() {
      return author;
   }
   public void setAuthor(String author) {
      this.author = author;
   }
   public String getDescription() {
      return description;
   }
   public void setDescription(String description) {
      this.description = description;
   }
   public String getIsbn() {
      return isbn;
   }
   public void setIsbn(String isbn) {
      this.isbn = isbn;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   
   @Override
   public String toString() {
      return "BookinfoDto [total=" + total + ", display=" + display + ", title=" + title + ", image=" + image
            + ", publisher=" + publisher + ", author=" + author + ", description=" + description + ", isbn=" + isbn
            + ", id=" + id + "]";
   }
   
}