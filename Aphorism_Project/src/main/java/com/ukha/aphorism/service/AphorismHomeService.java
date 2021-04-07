package com.ukha.aphorism.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.ukha.aphorism.data.Data;

@Service
public interface AphorismHomeService {
	//명언을 json형식으로 가지고 있는 웹페이지에 요청하여 json데이터를 가져오고 파싱하는 메소드_2021.04.07
	public List<Data> getData(ModelAndView mView);

}
