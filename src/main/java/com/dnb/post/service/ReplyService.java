package com.dnb.post.service;

import java.util.List;
import java.util.Map;

import com.dnb.post.model.ReplyDto;


public interface ReplyService {
	
	int writeReply(ReplyDto replyDto);
	String listReply(int post_no);
	int modifyReply(ReplyDto replyDto);
	int deleteReply(int reply_no);
	String getReply(int reply_no);
	
}
