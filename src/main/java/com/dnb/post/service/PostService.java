package com.dnb.post.service;

import java.util.List;
import java.util.Map;

import com.dnb.post.model.PostDto;

public interface PostService {

   int writePost(PostDto postDto);
   List<PostDto> selectPost(String id);
   PostDto getPost(int post_no);
   int modifyPost(PostDto postDto);
   void deletePost(int post_no);
   String getMyPostList(PostDto postDto);
   String mainPostList(int listLength);
   List<PostDto> listPost(Map<String,String> map);
   PostDto viewPost(int post_no);
   int updateLikeCount(int post_no);
   int cancelLikeCount(int post_no);
   String mainFollowList(Map<String,String> map);
   String searchMainList(Map<String,String> map);

}
