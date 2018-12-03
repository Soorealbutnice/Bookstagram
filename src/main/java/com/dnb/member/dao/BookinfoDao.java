package com.dnb.member.dao;


import java.util.List;


import com.dnb.member.model.BookinfoDto;
import com.dnb.post.model.PostDto;

public interface BookinfoDao {

	 String bookinfo(String word);
	  List<PostDto> reviewinfo(String isbn);

}
