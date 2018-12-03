package com.dnb.post.dao;

import java.util.List;
import java.util.Map;

import com.dnb.post.model.ReplyDto;


public interface ReplyDao {
	
	int writeReply(ReplyDto replyDto);
	List<ReplyDto> listReply(int post_no);
	int modifyReply(ReplyDto replyDto);
	int deleteReply(int reply_no);
	List<ReplyDto> getReply(int reply_no);

}
