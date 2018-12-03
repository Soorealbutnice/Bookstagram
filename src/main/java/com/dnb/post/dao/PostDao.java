package com.dnb.post.dao;

import java.util.List;
import java.util.Map;

import com.dnb.post.model.PostDto;

public interface PostDao {
	
	   int writePost(PostDto postDto);
	   List<PostDto> selectPost(String id);
	   PostDto getPost(int post_no);
	   int modifyPost(PostDto postDto);
	   int deletePost(int post_no);
	   List<PostDto> getMyPostList(PostDto postDto);
	   List<PostDto> mainPostList(int listLength);
	   PostDto viewPost(int post_no);
	   List<PostDto> listPost(Map<String,String> map);
	   int updateLikeCount(int post_no);
	   int cancelLikeCount(int post_no);
	   List<PostDto> mainFollowList(Map<String,String> map);
	   List<PostDto> searchMainList(Map<String,String> map);
	   int deletePin(int post_no);
	   int deleteReply(int post_no);
}
