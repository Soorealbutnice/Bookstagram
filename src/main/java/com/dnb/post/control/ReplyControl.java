package com.dnb.post.control;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dnb.member.model.MemberDto;
import com.dnb.post.model.ReplyDto;
import com.dnb.post.service.ReplyService;

@Controller
@RequestMapping("/reply")
public class ReplyControl {

	@Autowired
	private ReplyService replyService;

	@RequestMapping(value = "/writeReply.dnb", method = RequestMethod.POST, headers = {"Content-type=application/json" })
	public @ResponseBody String write(@RequestBody ReplyDto replyDto, HttpSession session) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if (memberDto != null) {
			replyDto.setReply_id(memberDto.getId());
			int cnt = replyService.writeReply(replyDto);
		}
		String replylist = replyService.listReply(replyDto.getPost_no());

		return replylist;
	}

	@RequestMapping(value = "/listReply.dnb", method = RequestMethod.GET)
	public @ResponseBody String list(@RequestParam(value = "post_no") int post_no) {
		String replylist = replyService.listReply(post_no);
		return replylist;
	}

	@RequestMapping(value = "/getReply.dnb", method = RequestMethod.GET)
	public @ResponseBody String getReply(@RequestParam(value = "reply_no") int reply_no) {
		ModelAndView mav = new ModelAndView();
		String reply = replyService.getReply(reply_no);
		return reply;
	}

	@RequestMapping(value = "/modifyReply.dnb", method = RequestMethod.GET)
	public @ResponseBody String modify(@RequestParam(value = "reply_no") int reply_no,
			@RequestParam(value = "post_no") int post_no, @RequestParam(value = "reply_content") String reply_content,
			HttpSession session) {

		ReplyDto replyDto = new ReplyDto();
		replyDto.setReply_content(reply_content);
		replyDto.setPost_no(post_no);
		replyDto.setReply_no(reply_no);

		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if (memberDto != null) {
			int cnt = replyService.modifyReply(replyDto);
		}
		String replylist = replyService.listReply(replyDto.getPost_no());
		return replylist;
	}

	@RequestMapping(value = "/deleteReply.dnb/{reply_no}", method = RequestMethod.DELETE)
	public @ResponseBody void delete(@PathVariable(value = "reply_no") int reply_no) {
		int cnt = replyService.deleteReply(reply_no);
	}

}
