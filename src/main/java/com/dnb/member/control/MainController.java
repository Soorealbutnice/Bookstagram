package com.dnb.member.control;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.dnb.member.model.MemberDto;
import com.dnb.member.service.FollowService;
import com.dnb.member.service.MemberService;
import com.dnb.post.service.PinService;
import com.dnb.post.service.PostService;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	private PostService postService;
	
	@Autowired
	private FollowService followService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PinService pinService;
	
	@RequestMapping(value="/firstComeMain.dnb")		
	public String firstComeMain() {
		return "commons/AllListMain";
	}
	
	@RequestMapping(value="/mainAllList.dnb", method=RequestMethod.GET)		
	public @ResponseBody String mainAllList(@RequestParam("listLength") int listLength, HttpSession session) {
		String postList = postService.mainPostList(listLength);
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		List<String> followList = followService.followerCheck(id);
		
		String listString = "";
		for (String s : followList)
		{
		    listString += s + "\t";
		}
		
		List<Integer> pinList = pinService.pinCheck(id);
		
		List<String> newList = new ArrayList<String>(pinList.size());
		for (Integer myInt : pinList) 
		{ 
		  newList.add(String.valueOf(myInt)); 
		}
		
		String pinListString = "";
		for (String s : newList)
		{
			pinListString += s + "\t";
		}
		
		session.setAttribute("followCheck", listString);
		session.setAttribute("pinList", pinListString);

		return postList;
	}
	
	@RequestMapping(value="/followMainCome.dnb")		
	public String FollowMainCome() {
		return "commons/FollowListMain";
	}
	
	@RequestMapping(value="/followList.dnb", method=RequestMethod.GET)		
	public @ResponseBody String followList(@RequestParam("listLength") int listLength, HttpSession session) {
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		
		Map map = new HashMap();
		map.put("id", id);
		map.put("listLength", listLength+"");
		String postList = postService.mainFollowList(map);
		
		List<String> followList = followService.followerCheck(id);
		
		String listString = "";
		for (String s : followList)
		{
		    listString += s + "\t";
		}
		
		List<Integer> pinList = pinService.pinCheck(id);

		List<String> newList = new ArrayList<String>(pinList.size());
		for (Integer myInt : pinList) 
		{ 
		  newList.add(String.valueOf(myInt)); 
		}
		
		String pinListString = "";
		for (String s : newList)
		{
			pinListString += s + "\t";
		}
		
		session.setAttribute("followCheck", listString);
		session.setAttribute("pinList", pinListString);
		
		return postList;
	}
	
	@RequestMapping(value="/searchMainCome.dnb")		
	public ModelAndView SearchMainCome(@RequestParam("searchWord") String searchWord) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("searchWord", searchWord);
		mav.setViewName("commons/searchMain");
		return mav;
	}
	
	@RequestMapping(value="/searchList.dnb", method=RequestMethod.GET)		
	public @ResponseBody String searchList(@RequestParam("listLength") int listLength, @RequestParam("searchWord") String searchWord, HttpSession session) {
		Map map = new HashMap();
		map.put("searchWord", searchWord);
		map.put("listLength", listLength+"");
		String postList = postService.searchMainList(map);
		
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		List<String> followList = followService.followerCheck(id);
		
		String listString = "";
		for (String s : followList)
		{
		    listString += s + "\t";
		}
		List<Integer> pinList = pinService.pinCheck(id);

		List<String> newList = new ArrayList<String>(pinList.size());
		for (Integer myInt : pinList) 
		{ 
		  newList.add(String.valueOf(myInt)); 
		}
		
		String pinListString = "";
		for (String s : newList)
		{
			pinListString += s + "\t";
		}
		
		session.setAttribute("followCheck", listString);
		session.setAttribute("pinList", pinListString);
		
		return postList;
	}
	
}
