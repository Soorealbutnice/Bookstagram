package com.dnb.post.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.dnb.post.service.PinService;

@Controller
public class PinControl {
	
	@Autowired
	private PinService pinService;

}
