package com.dnb.member.control;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dnb.member.model.FollowDto;
import com.dnb.member.model.MemberDto;
import com.dnb.member.service.FollowService;
import com.dnb.member.service.MemberService;



@Controller
@RequestMapping("/follow")
public class FollowControl {
	
	@Autowired
	private FollowService followService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/list.dnb")		
	public ModelAndView list(@RequestParam Map<String, String> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		List<FollowDto> list = followService.selectFollow(memberDto.getId());
		memberDto = memberService.getMember(memberDto.getId());
		mav.addObject("member", memberDto);
		mav.addObject("list", list);
		mav.setViewName("follow");
		return mav;
	}
	
	@RequestMapping("/follow.dnb")
	public @ResponseBody void follow(@RequestParam("followed_id") String followed_id, HttpSession session) {
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		FollowDto followDto = new FollowDto();
		followDto.setFollowed_id(followed_id);
		followDto.setFollower_id(id);
		if(followService.getFollower(followDto) == null) {
			followService.insertFollow(followDto);
		}
		
		List<String> followList = followService.followerCheck(id);
		String listString = "";
		for (String s : followList)
		{
		    listString += s + "\t";
		}
		session.setAttribute("followCheck", listString);

	}
	
	@RequestMapping("/cancelFollow.dnb")
	public @ResponseBody void cancelFollow(@RequestParam("followed_id") String followed_id, HttpSession session) {
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		FollowDto followDto = new FollowDto();
		followDto.setFollowed_id(followed_id);
		followDto.setFollower_id(id);
		FollowDto followDTO = followService.getFollower(followDto);
		if(followDTO.getFollower_id() != null) {
			followService.deleteFollow(followDTO.getFollow_no());
		}
		List<String> followList = followService.followerCheck(id);
		String listString = "";
		for (String s : followList)
		{
		    listString += s + "\t";
		}
		session.setAttribute("followCheck", listString);
	}
	

}
