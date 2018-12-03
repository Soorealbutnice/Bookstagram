package com.dnb.post.dao;

import com.dnb.post.model.HashtagDto;

public interface HashtagDao {
	
	HashtagDto selectHashtag();
	int updateHahtag(int hashtag_no);
	int deleteHashtag(int hashtag_no);

}
