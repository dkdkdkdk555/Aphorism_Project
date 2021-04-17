package com.ukha.aphorism.category.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ukha.aphorism.category.service.CategoryService;
import com.ukha.aphorism.data.Data;

@Controller
public class CategoryController {
	
	
	@RequestMapping("/category/category.do")
	public String category() {
		
		return "category/category";
	}
	
	@Autowired
	private CategoryService service; //카테고리서비스 DI
	
	//카테고리별 명언 ajax요청 받는 메소드_2021.04.16
	@RequestMapping("/category/data_category.do")
	@ResponseBody
	public List<Data> dataByCategory(@RequestParam String category){
		List<Data> list = service.putDataByCategory(category);
		return list;
	}
}
