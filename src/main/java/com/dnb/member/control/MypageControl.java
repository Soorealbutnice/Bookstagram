package com.dnb.member.control;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dnb.member.model.FollowDto;
import com.dnb.member.model.MemberDto;
import com.dnb.member.model.SupportDto;
import com.dnb.member.service.FollowService;
import com.dnb.member.service.MemberService;
import com.dnb.member.service.SupportService;
import com.dnb.post.model.PostDto;
import com.dnb.post.service.PostService;

@Controller
@RequestMapping("/mypage")
public class MypageControl {
	
	
	@Autowired
	private FollowService followService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PostService postService;
	
	@Autowired
	private SupportService supportService;
	
//////////////////////////////////////////////////////////////////////////review page ////////////////////////////////////////////////////////////	
	@RequestMapping(value="/mpreview.dnb", method=RequestMethod.GET)		
	public ModelAndView mpReview(@RequestParam("post_id") String post_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
			
		int postCount;
		int meFollowerCount;
		int followCount;

		List<FollowDto> followList = followService.selectFollow(post_id);
		List<FollowDto> mefollowList = followService.meFollowList(post_id);
		List<PostDto>postList = postService.selectPost(post_id);

		if(postList.isEmpty()) {
			postCount = 0;
		} else {
			postCount = postList.size();
		}
		
		if(mefollowList.size() == 0) {
			meFollowerCount = 0;
		} else {
			meFollowerCount = mefollowList.size();
		}
		
		if(followList.size() == 0) {
			followCount = 0;
		} else {
			followCount = followList.size();
		}
		
		MemberDto memberDtO = (MemberDto) session.getAttribute("userInfo");
		String id = memberDtO.getId();
		if(id != post_id) {
			FollowDto followDto = new FollowDto();
			followDto.setFollower_id(id);
			followDto.setFollowed_id(post_id);
			FollowDto followDTO = followService.getFollower(followDto);
			mav.addObject("followStatus", followDTO);
		}
	    MemberDto memberDto = memberService.getMember(post_id);
		mav.addObject("member", memberDto);
		mav.addObject("followList", followList);
		mav.addObject("mefollowList", mefollowList);
		mav.addObject("postCount", postCount);
		mav.addObject("meFollowerCount", meFollowerCount);
		mav.addObject("followCount", followCount);
		mav.setViewName("mypage/review");
		return mav;
	}
	
	@RequestMapping(value="/review.dnb", method=RequestMethod.GET)
	public @ResponseBody String reviewList(@RequestParam("post_no") int post_no, @RequestParam("post_id") String post_id, HttpSession session) {
		PostDto postDto = new PostDto();
		postDto.setPost_id(post_id);
		postDto.setPost_no(post_no);
		String postList = postService.getMyPostList(postDto);
		return postList;
	}
//////////////////////////////////////////////////////////////////////////review page ////////////////////////////////////////////////////////////	
	
	
//////////////////////////////////////////////////////////////////////////follow page ////////////////////////////////////////////////////////////	
	@RequestMapping("/mpfollow.dnb")		
	public ModelAndView mpFollow(@RequestParam("post_id") String post_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		int postCount;
		int meFollowerCount;
		int followCount;
	
		List<FollowDto> followList = followService.selectFollow(post_id);
		List<FollowDto> mefollowList = followService.meFollowList(post_id);
		List<PostDto>postList = postService.selectPost(post_id);
	
		if(postList.isEmpty()) {
			postCount = 0;
		} else {
			postCount = postList.size();
		}
		
		if(mefollowList.size() == 0) {
			meFollowerCount = 0;
		} else {
			meFollowerCount = mefollowList.size();
		}
		
		if(followList.size() == 0) {
			followCount = 0;
		} else {
			followCount = followList.size();
		}
		
		MemberDto memberDtO = (MemberDto) session.getAttribute("userInfo");
		String id = memberDtO.getId();
		if(id != post_id) {
			FollowDto followDto = new FollowDto();
			followDto.setFollower_id(id);
			followDto.setFollowed_id(post_id);
			FollowDto followDTO = followService.getFollower(followDto);
			mav.addObject("followStatus", followDTO);
		}
	
		MemberDto memberDto = memberService.getMember(post_id);
		mav.addObject("member", memberDto);
		mav.addObject("followList", followList);
		mav.addObject("mefollowList", mefollowList);
		mav.addObject("postCount", postCount);
		mav.addObject("meFollowerCount", meFollowerCount);
		mav.addObject("followCount", followCount);
		mav.setViewName("mypage/follow");
		return mav;
	}
	
	@RequestMapping(value="/follow.dnb", method=RequestMethod.GET)
	public @ResponseBody String followList(@RequestParam("follow_no") int follow_no, @RequestParam("follow_id") String follow_id, HttpSession session) {
		FollowDto followDto = new FollowDto();
		followDto.setFollower_id(follow_id);
		followDto.setFollow_no(follow_no);
		String followList = followService.myFollowList(followDto);
		return followList;
	}
	
//////////////////////////////////////////////////////////////////////////follow page /////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////My Supporter ////////////////////////////////////////////////////////////     
    
	@RequestMapping("/mpMySupporter.dnb")       
	public ModelAndView mySupporterList(@RequestParam Map<String, String> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		
		int postCount;
		int meFollowerCount;
		int followCount;
		
		List<FollowDto> followList = followService.selectFollow(id);
		List<FollowDto> mefollowList = followService.meFollowList(id);
		List<PostDto>postList = postService.selectPost(id);
		
		if(postList.isEmpty()) {
			postCount = 0;
		} else {
			postCount = postList.size();
		}
		
		if(mefollowList.size() == 0) {
			meFollowerCount = 0;
		} else {
			meFollowerCount = mefollowList.size();
		}
		
		if(followList.size() == 0) {
			followCount = 0;
		} else {
			followCount = followList.size();
		}
		
		memberDto = memberService.getMember(memberDto.getId());
		mav.addObject("member", memberDto);
		mav.addObject("followList", followList);
		mav.addObject("mefollowList", mefollowList);
		mav.addObject("postCount", postCount);
		mav.addObject("meFollowerCount", meFollowerCount);
		mav.addObject("followCount", followCount);
		mav.setViewName("mypage/MySupporter");
		return mav;
	}
	
	
	@RequestMapping(value="/msupport.dnb", method=RequestMethod.GET)
	public @ResponseBody String msupportList(@RequestParam("msupport_no") int msupport_no, HttpSession session) {
	MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
	String id = memberDto.getId();
	SupportDto supportDto = new SupportDto();
	supportDto.setId(id);
	supportDto.setSupport_no(msupport_no);
	String msupportList = supportService.mySupportList(supportDto);
	
	return msupportList;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping("/mpISupporter.dnb")        
	public ModelAndView iSupporterList(@RequestParam Map<String, String> map, HttpSession session) {
	ModelAndView mav = new ModelAndView();
	MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
	String id = memberDto.getId();
	int postCount;
	int meFollowerCount;
	int followCount;
	
	List<FollowDto> followList = followService.selectFollow(id);
	List<FollowDto> mefollowList = followService.meFollowList(id);
	List<PostDto>postList = postService.selectPost(id);
	
	if(postList.isEmpty()) {
		postCount = 0;
	} else {
		postCount = postList.size();
	}
	
	if(mefollowList.size() == 0) {
		meFollowerCount = 0;
	} else {
		meFollowerCount = mefollowList.size();
	}
	
	if(followList.size() == 0) {
		followCount = 0;
	} else {
		followCount = followList.size();
	}
	
	memberDto = memberService.getMember(memberDto.getId());
	mav.addObject("member", memberDto);
	mav.addObject("followList", followList);
	mav.addObject("mefollowList", mefollowList);
	mav.addObject("postCount", postCount);
	mav.addObject("meFollowerCount", meFollowerCount);
	mav.addObject("followCount", followCount);
	mav.setViewName("mypage/ISupport");
	return mav;
	}
	
	
	@RequestMapping(value="/isupport.dnb", method=RequestMethod.GET)
	public @ResponseBody String isList(@RequestParam("isupport_no") int isupport_no, HttpSession session) {
	MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
	String id = memberDto.getId();
	SupportDto supportDto = new SupportDto();
	supportDto.setId(id);
	supportDto.setSupport_no(isupport_no);
	String isupportList = supportService.selectSupport(supportDto);
	return isupportList;
	}
}