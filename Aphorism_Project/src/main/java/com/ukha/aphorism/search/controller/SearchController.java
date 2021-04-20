package com.ukha.aphorism.search.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ukha.aphorism.data.Data;
import com.ukha.aphorism.search.service.SearchService;

@Controller
public class SearchController {
	
	//search 메뉴 페이지 매핑 메소드_2021.04.20
	@RequestMapping("/search.do")
	public String search() {
		
		return "search";
	}
	
	//SearchService 객체 DI_2021.04.20
	@Autowired
	private SearchService service;
	
	//검색 ajax요청에 대해 응답하는 메소드_2021.04.20
	@RequestMapping("/search_data.do")
	@ResponseBody
	public List<Data> searchData(@RequestParam String keyword){
		List<Data> list = service.getData(keyword);
		
		return list;
	}
}
