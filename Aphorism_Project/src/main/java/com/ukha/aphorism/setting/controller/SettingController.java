package com.ukha.aphorism.setting.controller;

import java.util.List;


import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ukha.aphorism.data.Data;
import com.ukha.aphorism.setting.service.SettingService;

@Controller
public class SettingController {
	
	@RequestMapping("/setting/setting.do")
	public String settingPage() {
		return "setting/setting";
	}
	
	@Autowired 
	private SettingService service;
	
	//좋아요 모아보기 페이지
	@RequestMapping("/setting/like.do")
	public ModelAndView likePage(HttpServletRequest request) {
		
		List<Data> list = service.getLikeList(request);
		
		ModelAndView mView = new ModelAndView();
		mView.addObject("list", list);
		mView.setViewName("setting/like");
		
		return mView;
	}
	//언어설정 페이지
	@RequestMapping("/setting/language.do")
	public String languageSetting() {
		return "setting/language";
	}
	//배경설정 페이지
	@RequestMapping("/setting/backcolor.do")
	public String backColorSetting() {
		return "setting/backcolor";
	}
	//폰트설정 페이지
	@RequestMapping("/setting/font.do")
	public String fontSetting() {
		return "setting/font";
	}
	//잠금화면 앞에 실행 설정 페이지
	@RequestMapping("/setting/screen.do")
	public String screenSetting() {
		return "setting/screen";
	}
}
