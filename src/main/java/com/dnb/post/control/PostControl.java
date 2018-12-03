package com.dnb.post.control;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.RequestPartMethodArgumentResolver;
import org.springframework.web.servlet.view.RedirectView;

import com.dnb.member.model.BookinfoDto;
import com.dnb.member.model.FollowDto;
import com.dnb.member.model.MemberDto;
import com.dnb.member.service.FollowService;
import com.dnb.member.service.MemberService;
import com.dnb.post.model.HashtagDto;
import com.dnb.post.model.PinDto;
import com.dnb.post.model.PostDto;
import com.dnb.post.model.ReplyDto;
import com.dnb.post.service.HashtagService;
import com.dnb.post.service.PinService;
import com.dnb.post.service.PostService;

@Controller
@RequestMapping("/post")
public class PostControl {

	@Autowired
	private PostService postService;

	@Autowired
	private HashtagService hashtagService;

	@Autowired
	ServletContext servletContext;

	@Autowired
	private MemberService memberService;

	@Autowired
	private PinService pinService;

	@Autowired
	private FollowService followService;

	@RequestMapping(value = "write.dnb", method = RequestMethod.GET)
	public String write() {
		return "post/write";
	}
	
	
	@RequestMapping(value = "selectedWrite.dnb", method = RequestMethod.POST)
	public ModelAndView write(BookinfoDto bookinfoDto) {
		ModelAndView mav = new ModelAndView();
		
		String author = bookinfoDto.getAuthor();
		String publisher = bookinfoDto.getPublisher();
		String pubdate = bookinfoDto.getPubdate();
		String bookInfo = author+" | " + publisher +" | " + pubdate;
		PostDto postDto = new PostDto();
		postDto.setBookInfo(bookInfo);
		postDto.setBook_name(bookinfoDto.getTitle());
		postDto.setBookImg(bookinfoDto.getImage());
		postDto.setIsbn(bookinfoDto.getIsbn());
		mav.addObject("selectedBook", postDto );
		mav.setViewName("post/write");
		return mav;
	}

	@RequestMapping(value = "write.dnb", method = RequestMethod.POST)
	public String write(HttpSession session, PostDto postDto, Model model, @RequestParam("picture") MultipartFile multipartFile) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if (memberDto != null) {

			postDto.setPost_id(memberDto.getId());

			if (multipartFile != null && !multipartFile.isEmpty()) {

				String origin_postPicture = multipartFile.getOriginalFilename();
				// 나중에 파일 퍼미션 체크 (png, gif, jpeg, jpg 체크)
				String realPath = servletContext.getRealPath("/upload/album");

				DateFormat df = new SimpleDateFormat("yyMMdd");
				String psavefolder = df.format(new Date());// 180725
				String realSaveFolder = realPath + File.separator + psavefolder;

				File dir = new File(realSaveFolder);

				if (!dir.exists()) {
					dir.mkdirs();
				}

				String save_postPicture = UUID.randomUUID().toString()
						+ origin_postPicture.substring(origin_postPicture.lastIndexOf('.'));

				File file = new File(realSaveFolder, save_postPicture);
				try {
					multipartFile.transferTo(file);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}

				postDto.setOrigin_postPicture(origin_postPicture);
				postDto.setSave_postPicture(save_postPicture);
				postDto.setPsavefolder(psavefolder);
			} else {
				postDto.setOrigin_postPicture(" ");
				postDto.setSave_postPicture(" ");
				postDto.setPsavefolder(" ");
			}

			String hashtag1 = postDto.getHashtag1();
			String hashtag2 = postDto.getHashtag2();
			String hashtag3 = postDto.getHashtag3();
			String hashtag4 = postDto.getHashtag4();
			
			String search = postDto.getTitle()+postDto.getContent()+postDto.getSimpleReview()+postDto.getBook_name()+hashtag1+hashtag2+hashtag3+hashtag4;
			postDto.setSearch(search);
			int seq = postService.writePost(postDto);

			if (seq != 0) {
				model.addAttribute("post_no", seq);
			} else {
				model.addAttribute("errorMsg", "글작성 실패!");
			}
		} else {

			model.addAttribute("errorMsg", "로그인이 필요한 페이지입니다!");
		}

		return "commons/AllListMain";
	}

	@RequestMapping(value = "list.dnb", method = RequestMethod.GET)
	public ModelAndView list(@RequestParam Map<String, String> map) {
		ModelAndView mav = new ModelAndView();

		List<PostDto> list = postService.listPost(map);

		mav.addObject("list", list);
		mav.setViewName("commons/main");
		return mav;
	}

	@RequestMapping(value = "view.dnb", method = RequestMethod.GET)
	public String view(@RequestParam("post_no") int post_no, @RequestParam("post_id") String post_id,
			HttpSession session, ModelMap model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		String id = memberDto.getId();
		if (memberDto != null) {
			PostDto postDto = (PostDto) postService.viewPost(post_no);
			FollowDto followDto = new FollowDto();
			followDto.setFollower_id(id);
			followDto.setFollowed_id(post_id);
			FollowDto followDTO = followService.getFollower(followDto);
			model.addAttribute("followStatus", followDTO);
			model.addAttribute("article", postDto);

		}
		return "post/view";
	}

	@RequestMapping("/likePost.dnb")
	public @ResponseBody void like(@RequestParam("post_no") int post_no, HttpSession session) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		String id = memberDto.getId();
		PinDto pinDto = new PinDto();
		
		System.out.println(post_no);
		System.out.println(id);
		
		pinDto.setPost_no(post_no);
		pinDto.setPost_id(id);

		if (pinService.getMyPin(pinDto) == null) {
			int result = pinService.insertPin(pinDto);
			System.out.println(result);
			if (result == 1) {
				postService.updateLikeCount(post_no);
			}
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
		
		session.setAttribute("pinList", pinListString);
	}

	@RequestMapping("/cancelLike.dnb")
	public @ResponseBody void cancelLike(@RequestParam("post_no") int post_no, HttpSession session) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		String id = memberDto.getId();
		PinDto pinDto = new PinDto();
		pinDto.setPost_no(post_no);
		pinDto.setPost_id(id);

		if (pinService.getMyPin(pinDto) != null) {
			int result = pinService.deletePin(pinDto);
			if (result == 1) {
				postService.cancelLikeCount(post_no);
			}
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
		
		session.setAttribute("pinList", pinListString);
	}

	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public ModelAndView modify(HttpSession session, @RequestParam("post_no") int post_no) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		ModelAndView mav = new ModelAndView();
		if (memberDto != null) {
			PostDto postDto = postService.getPost(post_no);
			mav.addObject("article", postDto);
			mav.setViewName("post/modify");
		}

		return mav;
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyok(HttpSession session, PostDto postDto, Model model, @RequestParam("picture") MultipartFile multipartFile) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if (memberDto != null) {
			postDto.setPost_id(memberDto.getId());
			if (multipartFile != null && !multipartFile.isEmpty()) {
				String origin_postPicture = multipartFile.getOriginalFilename();
				String realPath = servletContext.getRealPath("/upload/album");

				DateFormat df = new SimpleDateFormat("yyMMdd");
				String psavefolder = df.format(new Date());// 180725
				String realSaveFolder = realPath + File.separator + psavefolder;
				File dir = new File(realSaveFolder);

				if (!dir.exists()) {
					dir.mkdirs();
				}

				String save_postPicture = UUID.randomUUID().toString()
						+ origin_postPicture.substring(origin_postPicture.lastIndexOf('.'));

				File file = new File(realSaveFolder, save_postPicture);
				try {
					multipartFile.transferTo(file);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}

				postDto.setOrigin_postPicture(origin_postPicture);
				postDto.setSave_postPicture(save_postPicture);
				postDto.setPsavefolder(psavefolder);
			} else {
				postDto.setOrigin_postPicture("nopic");
				postDto.setSave_postPicture("nopic");
				postDto.setPsavefolder("nopic");
			}

			String hashtag1 = postDto.getHashtag1();
			String hashtag2 = postDto.getHashtag2();
			String hashtag3 = postDto.getHashtag3();
			String hashtag4 = postDto.getHashtag4();

			if (hashtag1 == null) {
				postDto.setHashtag1(" ");
			}
			if (hashtag2 == null) {
				postDto.setHashtag2(" ");
			}
			if (hashtag3 != null) {
				postDto.setHashtag3(" ");
			}
			if (hashtag4 == null) {
				postDto.setHashtag4(" ");
			}
			
			String book_name = postDto.getBook_name();
			String bookInfo = postDto.getBookInfo();
			String bookImg = postDto.getBookImg();
			String isbn = postDto.getIsbn();
			postDto.setBook_name(book_name);
			postDto.setBookInfo(bookInfo);
			postDto.setBookImg(bookImg);
			postDto.setIsbn(isbn);
			
			String search = postDto.getTitle()+postDto.getContent()+postDto.getSimpleReview()+postDto.getBook_name()+hashtag1+hashtag2+hashtag3+hashtag4;
			postDto.setSearch(search);

			int seq = postService.modifyPost(postDto);

			if (seq != 0) {
				model.addAttribute("post_no", seq);
			} else {
				model.addAttribute("errorMsg", "글수정을 실패하였습니다");
			}
		} else {
			model.addAttribute("errorMsg", "로그인이 필요한 페이지입니다");
		}

		return "redirect:/post/view.dnb?post_no="+postDto.getPost_no()+"&post_id="+postDto.getPost_id();
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(@RequestParam("post_no") int post_no, HttpSession session) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if (memberDto != null) {
			postService.deletePost(post_no);
		}
		return "redirect:/main/firstComeMain.dnb";
	}
}
