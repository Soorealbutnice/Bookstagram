package com.dnb.post.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.dnb.post.service.HashtagService;

@Controller
public class HashtagControl {
	
	@Autowired
	private HashtagService hashtagService;

}
