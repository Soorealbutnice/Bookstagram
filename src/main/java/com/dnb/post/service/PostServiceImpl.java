package com.dnb.post.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dnb.member.dao.FollowDao;
import com.dnb.member.model.FollowDto;
import com.dnb.post.dao.PostDao;
import com.dnb.post.model.PostDto;

@Service
public class PostServiceImpl implements PostService {

	@Autowired
	SqlSession sqlSession;

	@Override
	public String mainPostList(int listLength) {
		List<PostDto> postList = sqlSession.getMapper(PostDao.class).mainPostList(listLength);
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for (PostDto postDTO : postList) {
			JSONObject post = new JSONObject();
			post.put("post_no", postDTO.getPost_no());
			post.put("book_name", postDTO.getBook_name());
			post.put("like_count", postDTO.getLike_count());
			post.put("content", postDTO.getContent());
			post.put("introduce", postDTO.getIntroduce());
			post.put("nickname", postDTO.getNickname());
			post.put("origin_proPicture", postDTO.getOrigin_proPicture());
			post.put("save_proPicture", postDTO.getSave_proPicture());
			post.put("mSaveFolder", postDTO.getSaveFolder());
			post.put("simpleReview", postDTO.getSimpleReview());
			post.put("title", postDTO.getTitle());
			post.put("hashtag1", postDTO.getHashtag1());
			post.put("hashtag2", postDTO.getHashtag2());
			post.put("hashtag3", postDTO.getHashtag3());
			post.put("hashtag4", postDTO.getHashtag4());
			post.put("post_id", postDTO.getId());

			post.put("origin_postPicture", postDTO.getOrigin_postPicture());
			post.put("save_postPicture", postDTO.getSave_postPicture());
			post.put("pSaveFolder", postDTO.getPsavefolder());

			jarray.put(post);
		}

		json.put("postList", jarray);

		return json.toString();
	}

	@Override
	public PostDto getPost(int post_no) {
		return sqlSession.getMapper(PostDao.class).getPost(post_no);
	}

	@Override
	public int modifyPost(PostDto postDto) {
		return sqlSession.getMapper(PostDao.class).modifyPost(postDto);
	}

	@Override
	@Transactional
	public void deletePost(int post_no) {
		PostDao postDao = sqlSession.getMapper(PostDao.class);
		postDao.deleteReply(post_no);
		postDao.deletePin(post_no);
		postDao.deletePost(post_no);
	}

	@Override
	public String getMyPostList(PostDto postDto) {
		List<PostDto> postList = sqlSession.getMapper(PostDao.class).getMyPostList(postDto);
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for (PostDto postDTO : postList) {
			JSONObject post = new JSONObject();
			post.put("post_no", postDTO.getPost_no());
			post.put("write_date", postDTO.getWrite_date());
			post.put("title", postDTO.getTitle());
			post.put("content", postDTO.getContent());
			post.put("book_name", postDTO.getBook_name());
			post.put("origin_postPicture", postDTO.getOrigin_postPicture());
			post.put("save_postPicture", postDTO.getSave_postPicture());
			post.put("psaveFolder", postDTO.getPsavefolder());
			post.put("simplereview", postDTO.getSimpleReview());
			post.put("like_count", postDTO.getLike_count());
			post.put("post_id", postDTO.getPost_id());
			post.put("bookImg", postDTO.getBookImg());
			post.put("bookInfo", postDTO.getBookInfo());

			jarray.put(post);
		}
		json.put("postList", jarray);

		return json.toString();
	}

	@Override
	public List<PostDto> selectPost(String id) {
		return sqlSession.getMapper(PostDao.class).selectPost(id);
	}

	@Override
	public int writePost(PostDto postDto) {
		return sqlSession.getMapper(PostDao.class).writePost(postDto);
	}

	@Override
	public List<PostDto> listPost(Map<String, String> map) {
		return sqlSession.getMapper(PostDao.class).listPost(map);
	}

	@Override
	public PostDto viewPost(int post_no) {
		PostDto postDto = sqlSession.getMapper(PostDao.class).viewPost(post_no);
		if (postDto != null)
			if(postDto.getContent() != null) {
			postDto.setContent(postDto.getContent().replaceAll("\n", "<br>"));
			}
		return postDto;
	}

	@Override
	public int updateLikeCount(int post_no) {
		return sqlSession.getMapper(PostDao.class).updateLikeCount(post_no);
	}

	@Override
	public int cancelLikeCount(int post_no) {
		return sqlSession.getMapper(PostDao.class).cancelLikeCount(post_no);
	}

	@Override
	public String mainFollowList(Map<String, String> map) {
		List<PostDto> postList = sqlSession.getMapper(PostDao.class).mainFollowList(map);
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for (PostDto postDTO : postList) {
			JSONObject post = new JSONObject();
			post.put("post_no", postDTO.getPost_no());
			post.put("book_name", postDTO.getBook_name());
			post.put("like_count", postDTO.getLike_count());
			post.put("content", postDTO.getContent());
			post.put("introduce", postDTO.getIntroduce());
			post.put("nickname", postDTO.getNickname());
			post.put("origin_proPicture", postDTO.getOrigin_proPicture());
			post.put("save_proPicture", postDTO.getSave_proPicture());
			post.put("mSaveFolder", postDTO.getSaveFolder());
			post.put("simpleReview", postDTO.getSimpleReview());
			post.put("title", postDTO.getTitle());
			post.put("hashtag1", postDTO.getHashtag1());
			post.put("hashtag2", postDTO.getHashtag2());
			post.put("hashtag3", postDTO.getHashtag3());
			post.put("hashtag4", postDTO.getHashtag4());

			post.put("post_id", postDTO.getId());
			post.put("origin_postPicture", postDTO.getOrigin_postPicture());
			post.put("save_postPicture", postDTO.getSave_postPicture());
			post.put("pSaveFolder", postDTO.getPsavefolder());

			jarray.put(post);
		}

		json.put("postList", jarray);

		return json.toString();
	}

	@Override
	public String searchMainList(Map<String, String> map) {
		List<PostDto> postList = sqlSession.getMapper(PostDao.class).searchMainList(map);
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for (PostDto postDTO : postList) {
			JSONObject post = new JSONObject();
			post.put("post_no", postDTO.getPost_no());
			post.put("book_name", postDTO.getBook_name());
			post.put("like_count", postDTO.getLike_count());
			post.put("content", postDTO.getContent());
			post.put("introduce", postDTO.getIntroduce());
			post.put("nickname", postDTO.getNickname());
			post.put("origin_proPicture", postDTO.getOrigin_proPicture());
			post.put("save_proPicture", postDTO.getSave_proPicture());
			post.put("mSaveFolder", postDTO.getSaveFolder());
			post.put("simpleReview", postDTO.getSimpleReview());
			post.put("title", postDTO.getTitle());
			post.put("hashtag1", postDTO.getHashtag1());
			post.put("hashtag2", postDTO.getHashtag2());
			post.put("hashtag3", postDTO.getHashtag3());
			post.put("hashtag4", postDTO.getHashtag4());

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
