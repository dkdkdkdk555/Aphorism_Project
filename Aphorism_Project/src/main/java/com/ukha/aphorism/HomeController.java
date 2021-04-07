package com.ukha.aphorism;

import java.text.DateFormat;


import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ukha.aphorism.data.Data;
import com.ukha.aphorism.service.AphorismHomeService;



@Controller
public class HomeController {
	
	@Autowired
	private AphorismHomeService service;
	
	//home.jsp 매핑메소드_2021.04.06
	@RequestMapping("/home.do")
	public ModelAndView home(ModelAndView mView) {
		
		List<Data> list = service.getData(mView);
		mView.addObject("list", list);
		mView.setViewName("home");
		
		return mView;
	}
	

}
