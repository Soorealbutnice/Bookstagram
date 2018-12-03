package com.dnb.member.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.dnb.member.dao.BookinfoDao;
import com.dnb.member.model.BookinfoDto;
import com.dnb.post.model.PostDto;


@Service
public class BookinfoServiceImpl implements BookinfoService {
   
   @Autowired
   private SqlSession sqlSession;

   @Override
   public String bookinfo(String word) {
         
       String clientID="JQ1nEjFYk48JTDOjC522";
       String clientSecret = "bsTg3qRqoA";
       JSONObject json = new JSONObject();
       JSONArray jarray = new JSONArray();
       JSONObject book = null;
       ArrayList<BookinfoDto> list = null;
       ArrayList<BookinfoDto> resultlist= null;
       
         try {
            String sword = URLEncoder.encode(word, "UTF-8");
              URL url = new URL("https://openapi.naver.com/v1/search/book.xml?display=100&query="+sword);
              URLConnection urlConn=url.openConnection(); //openConnection 해당 요청에 대해서 쓸 수 있는 connection 객체 
              
              urlConn.setRequestProperty("X-Naver-Client-ID", clientID);
              urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
              
              BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream(),"UTF-8"));
              
              String data="";
              String msg = null;
              while((msg = br.readLine())!=null)
              {
                  data += msg;
              }
              
              list = null;//결과데이터 담을 리스트 
               XmlPullParserFactory factory;
               BookinfoDto dto = null;
               factory = XmlPullParserFactory.newInstance();
               XmlPullParser parser = factory.newPullParser(); //연결하는거 담고 
               parser.setInput(new StringReader(data));
               int eventType= parser.getEventType();
               
               while(eventType != XmlPullParser.END_DOCUMENT){
                  
                   switch(eventType){
                   case XmlPullParser.END_DOCUMENT://문서의 끝 
                       break;
                   case XmlPullParser.START_DOCUMENT:
                       list = new ArrayList<BookinfoDto>();
                       break;
                   case XmlPullParser.END_TAG:{
                       String tag = parser.getName();
                       if(tag.equals("item")){
                           list.add(dto);
                           dto = null;
                       }
                   }
                       
                   case XmlPullParser.START_TAG:{ //무조건 시작하면 만남 
                       String tag = parser.getName();                 
                       switch(tag){
                       case "item": //item가 열렸다는것은 새로운 책이 나온다는것 
                          dto = new BookinfoDto();
                           break;
                       case "title":
                           if(dto!=null)
                              dto.setTitle(parser.nextText());
                           break;
                       case "image":
                           if(dto!=null)
                              dto.setImage(parser.nextText());
                           break;
                       case "author":
                           if(dto!=null)
                              dto.setAuthor(parser.nextText());
                           break;
                       case "pubdate":
                           if(dto!=null)
                              dto.setPubdate(parser.nextText());
                           break;
                       case "description":
                           if(dto!=null)
                              dto.setDescription(parser.nextText());
                           break;
                       case "isbn":
                           if(dto!=null)
                              dto.setIsbn(parser.nextText());
                           break;
                       case "publisher":
                          if(dto!=null)
                             dto.setPublisher(parser.nextText());
                       }
                       break; 
                   } //case 끝
               } //switch끝
               eventType =parser.next();
              
          } //while문 끝

         } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
         } catch (XmlPullParserException e) {
            e.printStackTrace();
         } catch (IOException e) {
            e.printStackTrace();
         }
         for(BookinfoDto dto : list) {
            book = new JSONObject();
            book.put("description", dto.getDescription());
            book.put("title", dto.getTitle());
            book.put("author", dto.getAuthor());
            book.put("pubdate", dto.getPubdate());
            book.put("publisher", dto.getPublisher());
            book.put("image", dto.getImage());
            book.put("isbn", dto.getIsbn());
            jarray.put(book);
         }
            
         json.put("booklist", jarray);
       return json.toString();
   }
   
   @Override
   public String reviewinfo(String isbn) {
   List<PostDto> postList = sqlSession.getMapper(BookinfoDao.class).reviewinfo(isbn);
   JSONObject json = new JSONObject();
   JSONArray jarray = new JSONArray();
   for(PostDto postDTO : postList) {
      JSONObject post = new JSONObject();
      post.put("post_no", postDTO.getPost_no());
      post.put("book_name", postDTO.getBook_name());
      post.put("introduce", postDTO.getIntroduce());
      post.put("nickname", postDTO.getNickname());   
      post.put("save_proPicture", postDTO.getSave_proPicture());      
      post.put("mSaveFolder", postDTO.getSaveFolder());      
      post.put("simpleReview", postDTO.getSimpleReview());      
      post.put("title", postDTO.getTitle());
      post.put("bookImg", postDTO.getBookImg());
      post.put("post_id", postDTO.getId());
      post.put("origin_postPicture", postDTO.getOrigin_postPicture());
      post.put("save_postPicture", postDTO.getSave_postPicture());
      post.put("pSaveFolder", postDTO.getPsavefolder());   

      jarray.put(post);
   }
   
   json.put("postList", jarray);
   
   return json.toString();
}
}