package com.purple.bbs.ssm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CaseController {

	
	@RequestMapping("gocase")
	public String goToCasePage(){
		
		return "case/case";
		
	}
}
