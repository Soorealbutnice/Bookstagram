package com.dnb.post.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dnb.post.dao.ReplyDao;
import com.dnb.post.model.ReplyDto;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int writeReply(ReplyDto replyDto) {
		return sqlSession.getMapper(ReplyDao.class).writeReply(replyDto);
	}

	@Override
	public String listReply(int post_no) {
		List<ReplyDto> list = sqlSession.getMapper(ReplyDao.class).listReply(post_no);
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();	
		for(ReplyDto replyDto : list) {
			JSONObject reply = new JSONObject();
			reply.put("reply_no", replyDto.getReply_no());
			reply.put("post_no", replyDto.getPost_no());
			reply.put("reply_id", replyDto.getReply_id());
			reply.put("nickName", replyDto.getNickname());
			reply.put("reply_content", replyDto.getReply_content());
			reply.put("reply_date", replyDto.getReply_date());
			reply.put("save_proPicture", replyDto.getSave_proPicture());
			reply.put("saveFolder", replyDto.getSaveFolder());

			jarray.put(reply);
		}
		json.put("replylist", jarray);
		return json.toString();
	}

	@Override
	public int modifyReply(ReplyDto replyDto) {
		return sqlSession.getMapper(ReplyDao.class).modifyReply(replyDto);
	}

	@Override
	public int deleteReply(int reply_no) {
		return sqlSession.getMapper(ReplyDao.class).deleteReply(reply_no);
	}
	
	@Override
	public String getReply(int reply_no) {
		List<ReplyDto> list = sqlSession.getMapper(ReplyDao.class).getReply(reply_no);
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();	
		for(ReplyDto replyDto : list) {
			JSONObject reply = new JSONObject();
			reply.put("reply_no", replyDto.getReply_no());
			reply.put("post_no", replyDto.getPost_no());
			reply.put("reply_id", replyDto.getReply_id());
			reply.put("nickName", replyDto.getNickname());
			reply.put("reply_content", replyDto.getReply_content());
			reply.put("reply_date", replyDto.getReply_date());
			reply.put("save_proPicture", replyDto.getSave_proPicture());
			reply.put("saveFolder", replyDto.getSaveFolder());

			jarray.put(reply);
		}
		json.put("reply", jarray);
		return json.toString();
	}
	
	
}
