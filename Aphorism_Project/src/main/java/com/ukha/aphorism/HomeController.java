package com.ukha.aphorism;

import java.text.DateFormat;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
		
		List<Data> list = service.getData(); //명언객체리스트 받기
		//명언 객체중 랜덤으로 하나만 뷰페이지에 전달
		int ran = new Random().nextInt(list.size()-1);
		System.out.println(ran);
		Data data = null; // 뷰페이지에 전달할 명언
		int sizeHalf = (int) list.size()/2;
		if(ran >= 0) {
			data = list.get(ran);
		} else {
			data = list.get(sizeHalf); 
		}
		mView.addObject("data", data);
		mView.addObject("size", sizeHalf);
		mView.setViewName("home");
		
		return mView;
	}
	
	//quote.do 매핑메소드(이전, 다음 명언 출력 ajax 요청처리)_2021.4.12
	@RequestMapping("/quote.do")
	@ResponseBody
	public Map<String, Object> next_prev(@RequestParam int id, @RequestParam String btn){
		Data data = service.getNext_Prev(id, btn);
		//data객체  필드값 얻기
		int resId = data.getId();
		String descripK = data.getDescripK();
		String authK = data.getAuthK();
		String descripE = data.getDescripE();
		String authE = data.getAuthE();
		//map데이터로 포장
		Map<String, Object> wrapData = new HashMap<String, Object>();
		wrapData.put("id", resId);
		wrapData.put("descripK", descripK);
		wrapData.put("authK", authK);
		wrapData.put("descripE", descripE);
		wrapData.put("authE", authE);
		
		return wrapData;
	}

}
