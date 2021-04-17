package com.ukha.aphorism.category.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.ukha.aphorism.data.Data;

@Service
public interface CategoryService {
	//요청받은 카테고리의 명언들을 세션영역에 집어넣는 로직_2021.04.16
	public List<Data> putDataByCategory(String category);
}
