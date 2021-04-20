package com.ukha.aphorism.search.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ukha.aphorism.data.Data;

@Service
public interface SearchService {
	
	//전달받은 keyword에 대한 명언 검색결과를 list로 리턴하는 메소드_2021.04.20
	public List<Data> getData(String keyword);

}
