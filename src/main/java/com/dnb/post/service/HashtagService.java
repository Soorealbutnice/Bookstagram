package com.dnb.post.service;

import com.dnb.post.model.HashtagDto;

public interface HashtagService {
	
	HashtagDto selectHashtag();
	int updateHahtag(int hashtag_no);
	int deleteHashtag(int hashtag_no);

}
